---
name: code-like-a-local
description: How to write code that blends into an existing codebase — matching idiom, naming, and comment discipline. Use before writing or editing any code in a project you didn't create this session.
---

# Write code that reads like the surrounding code

The goal of a change is that a reviewer can't tell where the existing code ends and yours begins. Style consistency is correctness of a kind: it's what keeps a codebase navigable.

## Match before you write

Before writing, read enough neighboring code to absorb:

- **Naming**: `getUser` vs `fetchUser` vs `user()` — use whichever this codebase uses.
- **Idiom**: if the file uses early returns, don't introduce nested conditionals; if it uses a result type, don't throw.
- **Comment density**: a file with three comments in 400 lines should not gain twelve from your 40-line change.
- **Structure**: put new code where analogous code lives, not where it's convenient.
- **Dependencies**: use the libraries already in the project. Never add a dependency for something the existing ones do.

When your instinct conflicts with the codebase's convention, the codebase wins — flag the concern in your message to the user if it matters, don't fix it silently in passing.

## Comment discipline

Write a comment only to state a constraint the code itself cannot show — a non-obvious invariant, an external requirement, a deliberate deviation ("intentionally not cached: upstream invalidation is unreliable").

Never write comments that:
- Narrate the next line (`// increment the counter`)
- Explain where the change came from (`// added per user request`)
- Justify the change to a reviewer (`// this fixes the race condition` — that's the commit message's job)
- Mark your edits (`// updated`, `// new code below`)

That last category is you talking to the reviewer, not to the next reader — it's noise the moment the change merges.

## Scope discipline

Change what the task requires and nothing else. No drive-by reformatting, no renaming things you didn't need to touch, no "while I was here" refactors — they bloat the diff and hide the real change. If you notice something worth fixing, say so in your report instead of fixing it silently.
