#!/usr/bin/env bash
# Stop hook: block ending the turn when code was edited this session and the
# last test run happened BEFORE the last code edit (or never). A deterministic
# backstop for the run-guardrails-on-code-changes and verify-by-exercising
# skills — including the stale-test case where a suite passed early in a long
# session and the code changed afterward.
#
# This is a template — adapt TEST_PATTERN below to your projects' real test
# entrypoints. Known limitation: file changes made through shell commands
# (sed, patch, code generators) are not tracked as edits; only Edit/Write/
# NotebookEdit tool calls are.

# capture the hook's JSON input before the heredoc claims stdin
INPUT="$(cat)"

python3 - "$INPUT" <<'PY'
import json, re, sys

data = json.loads(sys.argv[1] or "{}")

# Never loop: if a previous Stop hook already blocked once, let the turn end.
if data.get("stop_hook_active"):
    sys.exit(0)

DOC_SUFFIXES = (".md", ".txt", ".rst")
TEST_PATTERN = re.compile(
    r"npm (run )?test|npx (vitest|jest|playwright)|pytest|go test|cargo test"
    r"|make (test|check)|mvn (test|verify)|gradle(w)? test"
)

# Walk the transcript in order, tracking the last code edit and the last
# actually-executed test command (prose mentions don't count).
last_edit = last_test = -1
try:
    with open(data["transcript_path"], encoding="utf-8") as f:
        for i, line in enumerate(f):
            try:
                entry = json.loads(line)
            except ValueError:
                continue
            message = entry.get("message") or {}
            content = message.get("content")
            if not isinstance(content, list):
                continue
            for block in content:
                if not isinstance(block, dict) or block.get("type") != "tool_use":
                    continue
                name = block.get("name", "")
                inp = block.get("input") or {}
                if name in ("Edit", "Write", "NotebookEdit"):
                    path = inp.get("file_path") or inp.get("notebook_path") or ""
                    if path and not path.endswith(DOC_SUFFIXES):
                        last_edit = i
                elif name == "Bash":
                    if TEST_PATTERN.search(inp.get("command", "")):
                        last_test = i
except (KeyError, OSError):
    sys.exit(0)  # no readable transcript — stay out of the way

if last_edit == -1 or last_test > last_edit:
    sys.exit(0)

if last_test == -1:
    reason = "no test command was run this session"
else:
    reason = "code was edited after the last test run, so the results are stale"

print(
    f"Code files were changed but {reason}. Rerun the project's tests before "
    "finishing — or state explicitly in your final message why they cannot be "
    "run and what remains unverified.",
    file=sys.stderr,
)
sys.exit(2)  # exit 2 blocks the stop; stderr is fed back to Claude
PY
