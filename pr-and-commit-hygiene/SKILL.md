---
name: pr-and-commit-hygiene
description: How to shape commits and pull requests so they are easy to review — small coherent diffs, structural changes separated from behavioral ones, commit messages that carry the why. Use when committing, opening a PR, or splitting up a large change.
---

# PR and commit hygiene

Review is the bottleneck of team delivery, and diff shape is what sets review speed. A change that is easy to review gets better review, sooner.

## Keep changes small and coherent

- One logical change per PR. "Fix the timeout bug" and "rename the client module" are two PRs even if you did them in the same sitting.
- If a PR needs the word "also" in its description, it's usually two PRs.
- Large features ship as a sequence of small, individually shippable PRs — each one leaving the codebase working — not one monolith at the end.

## Separate structural from behavioral changes

- A rename, move, or reformat mixed into a behavior change makes both unreviewable: the real change hides inside hundreds of mechanical lines.
- Do the structural change first as its own commit or PR ("no behavior change" — a claim the reviewer can verify by running tests), then the behavioral change as a small readable diff on top.

## Commit messages carry the why

The subject line says what changed; the body says why — the context that has nowhere else to live. Code comments shouldn't justify changes to reviewers (that discipline is `code-like-a-local`), which makes the commit message exactly where that reasoning belongs.

- Bad: `fix bug` / `update handler` / `address review comments`
- Good: a subject naming the change, and a body with why it was needed, what alternative was rejected, and any non-obvious consequence.

The test: could a teammate running `git log` on this file in a year reconstruct why the code is this way?

## Write the PR description for the reviewer

- Lead with the outcome: what does this change do, and why now.
- Say how it was verified — the command run, the tests added, the flow exercised.
- Point the reviewer at the risky part ("the retry logic in `worker.py` is the piece worth scrutiny; the rest is plumbing").
- Note what's deliberately out of scope, so the reviewer doesn't relitigate it.

## Non-negotiables

- Do not mix drive-by refactors, reformatting, or renames into a behavior change.
- Do not write commit messages that restate the diff and omit the reason.
- Do not open a PR whose verification you cannot describe.
- Do not force the reviewer to reverse-engineer which of 800 lines is the real change.
