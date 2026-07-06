# Hooks: enforcement instead of hope

Skills are instructions — the model usually follows them, but nothing guarantees it. Claude Code hooks run real commands at fixed points in the session, so the two behaviors that matter most can be *enforced*:

| Hook | Event | What it guarantees |
|---|---|---|
| `session-start-fable.sh` | SessionStart | fable-mode is active in every session — nobody has to remember `/fable-mode` |
| `stop-code-change-guard.sh` | Stop | the turn cannot end with unverified code changes: if code was edited and no test command ran **after the last edit**, Claude is sent back to run them (or to state explicitly why it can't) |

## Install

```bash
mkdir -p ~/.claude/hooks
cp hooks/session-start-fable.sh hooks/stop-code-change-guard.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

Then merge `hooks/settings.json.example` into `~/.claude/settings.json` (or a project's `.claude/settings.json` to scope it to one repo). If the file already has a `hooks` key, add these entries to it rather than replacing it.

The SessionStart hook expects the skills installed at `~/.claude/skills/` (see the main README). If they live elsewhere, set `FABLE_SKILL_PATH` to the full path of `fable-mode/SKILL.md`.

## Adapt the stop guard to your projects

`stop-code-change-guard.sh` is a template. Its `TEST_PATTERN` regex lists common test entrypoints (`npm test`, `pytest`, `go test`, `cargo test`, `make test`, …) — edit it to match how your repos actually run checks. Design choices to know about:

- **Ordering, not presence.** It parses the session transcript's tool events and requires the last test command to come *after* the last code edit — a suite that passed early in a long session doesn't excuse edits made since. Prose that merely mentions a test command doesn't count; only an executed Bash call does.
- **Only tool edits are tracked.** Edit/Write/NotebookEdit calls to non-doc files count as code changes; file changes made through shell commands (sed, patch, generators) are invisible to it. If your agents write code via shell, extend the Bash branch to also match write-ish commands.
- **It cannot loop.** When a Stop hook has already blocked once (`stop_hook_active`), the script exits 0 — so a genuinely blocked session can still end after Claude explains itself. It also stays silent when the transcript is missing or unreadable.

## Why hooks and not more instructions

An instruction competes with everything else in context; a hook is a hard gate. The skills tell the model *how* to verify and report — the stop guard makes "ended the turn without running anything" mechanically impossible to do silently. Use instructions for judgment, hooks for invariants.
