---
name: systematic-debugging
description: How to hunt down bugs methodically — reproduce first, test one hypothesis at a time, bisect when lost. Use whenever investigating a bug, a failing test, or behavior that contradicts expectations.
---

# Debug systematically

Debugging time is lost to two habits: fixing before reproducing, and changing several things at once. The method below is slower per step and much faster per bug.

## Reproduce first

- Do not change code until you can trigger the failure on demand. A bug you cannot reproduce is a bug you cannot verify a fix for.
- Reduce the reproduction to the smallest input, command, or test that still fails. Every element you remove narrows where the bug can live.
- If the bug is intermittent, find what makes it more frequent before hunting the cause — a 1-in-3 failure is debuggable, a 1-in-300 failure is a stakeout.
- Capture the reproduction as a failing test when practical. It becomes the fix's verification and the regression guard for free.

## One hypothesis at a time

- State the hypothesis before testing it: "if X is the cause, then doing Y should show Z."
- Test the cheapest hypothesis first — a config value or an environment difference is a 30-second check; a race condition is an afternoon.
- Change one variable per experiment. If you change two things and the bug disappears, you have learned almost nothing.
- When an experiment rules a hypothesis out, say so and move on. Ruled-out causes are progress worth reporting.

## Read the error — actually read it

- The full message, the stack trace, the line numbers, the *first* error rather than the last one in a cascade.
- Do not pattern-match a familiar-looking error to a known cause without confirming. The same message often has several different origins.
- When behavior contradicts your model of the code, believe the behavior; your model is what's wrong.

## Bisect when lost

- When there is no leading hypothesis, cut the search space in half: `git bisect` across history, binary-search over the input, or disable half the pipeline at a time.
- "When did this last work?" is often the fastest question available — a recent regression narrows the suspects to a diff you can read.

## Fix the cause, not the symptom

- A retry, a sleep, a broadened catch block, or a null check that silences the crash without explaining it is a symptom patch. It moves the failure somewhere less observable.
- You should be able to say *why* the bug happened in one sentence before you write the fix. If you can't, keep digging or say plainly that the fix is speculative.
- After the fix, rerun the original reproduction and confirm it passes for the reason you expect.

## Non-negotiables

- Do not claim a fix for a bug you never reproduced.
- Do not change multiple candidate causes in one experiment.
- Do not dismiss evidence that contradicts your hypothesis — that evidence is the lead.
- If time runs out, report what was ruled out, what remains suspect, and the exact reproduction steps — that is a valuable result, not a failure.
