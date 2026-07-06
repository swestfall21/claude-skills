#!/usr/bin/env bash
# Stop hook: block ending the turn when code was changed but no test/check
# command was observed in the session. A deterministic backstop for the
# run-guardrails-on-code-changes and verify-by-exercising skills.
#
# This is a template — adapt TEST_PATTERN below to your project's real
# test entrypoints. It errs on the permissive side: any matching command
# anywhere in the transcript satisfies it.

# capture the hook's JSON input before the heredoc claims stdin
INPUT="$(cat)"

python3 - "$INPUT" <<'PY'
import json, re, subprocess, sys

data = json.loads(sys.argv[1] or "{}")

# Never loop: if a previous Stop hook already blocked once, let the turn end.
if data.get("stop_hook_active"):
    sys.exit(0)

# Any non-doc changes in the working tree?
try:
    out = subprocess.run(
        ["git", "status", "--porcelain"],
        capture_output=True, text=True, timeout=10,
    ).stdout
except Exception:
    sys.exit(0)  # not a git repo / git unavailable — stay out of the way

DOC_SUFFIXES = (".md", ".txt", ".rst")
changed = [
    line for line in out.splitlines()
    if line.strip() and not line.split()[-1].endswith(DOC_SUFFIXES)
]
if not changed:
    sys.exit(0)

# Was a test/check command run at some point this session?
TEST_PATTERN = re.compile(
    r"npm (run )?test|npx (vitest|jest|playwright)|pytest|go test|cargo test"
    r"|make (test|check)|mvn (test|verify)|gradle(w)? test"
)
try:
    with open(data["transcript_path"], encoding="utf-8") as f:
        for line in f:
            if TEST_PATTERN.search(line):
                sys.exit(0)
except (KeyError, OSError):
    sys.exit(0)

print(
    "Code files were changed this session but no test command was observed. "
    "Run the project's tests before finishing — or state explicitly in your "
    "final message why they cannot be run and what remains unverified.",
    file=sys.stderr,
)
sys.exit(2)  # exit 2 blocks the stop; stderr is fed back to Claude
PY
