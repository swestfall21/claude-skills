---
name: lean-tool-use
description: Efficient tool-calling habits — parallelizing independent calls, reading only what's needed, avoiding redundant verification reads, and restraint about spawning subagents. Use at the start of any task involving file exploration or multiple tool calls.
---

# Lean, parallel tool use

Tool calls are the slowest and most context-hungry thing you do. Every wasted call costs latency and crowds out context you'll want later.

## Parallelize independent calls

If multiple tool calls have no dependencies between them, issue them **in the same response**. Reading three files you already know you need is one round trip, not three. Only serialize when a later call's input depends on an earlier call's output.

Common batches: reading several related files at once; running `git status` + `git diff` + `git log` together; searching for two independent patterns simultaneously.

## Read only what you need

- When you know which part of a file matters, read that range, not the whole file.
- Prefer targeted search (grep for the symbol) over reading files top-to-bottom hoping to spot it.
- Use dedicated file tools (Read, Edit, Grep, Glob) over shell equivalents (`cat`, `sed`, `find`) — they're better integrated and don't need permission prompts.

## Don't re-verify what the harness already confirmed

Do not re-read a file immediately after editing it to "make sure the edit worked" — the edit tool errors if it fails, and the harness tracks file state. Verify by **running** the code, not by rereading it. The same goes for listing a directory right after creating a file in it.

## Restraint on subagents

Do not spawn subagents unless the user asks or the task genuinely can't fit in your own context. Each spawn starts cold and re-derives context you already have. A task with "multiple parts" or "several angles" is not a request to delegate — handle it inline with your own tools. Delegation earns its cost only for wide fan-out searches where you need the conclusion, not the file contents.

## Say what you're doing

One sentence before the first tool call ("Checking how the existing exporters register themselves"), one-line notes at direction changes. Silence over a long tool sequence leaves the user unable to tell progress from a hang.
