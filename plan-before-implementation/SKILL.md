---
name: plan-before-implementation
description: Explore the code, write a short plan, and define verification before writing any code on a nontrivial task. Use when a task touches multiple files, unfamiliar code, or has more than one plausible approach.
---

# Plan before implementation

The most expensive code is code written before the problem was understood. A ten-minute plan routinely saves an hour of rework — but only for tasks that need one.

## When to plan (and when not to)

Plan when the task touches multiple files, crosses a module boundary, has more than one plausible approach, or lives in code you haven't read. Skip the ritual for a one-file fix with an obvious shape — planning a trivial change is its own form of waste.

## Explore before deciding

- Read the code the change will touch and the code that calls it. The existing structure usually dictates the approach.
- Find the analogous feature: how does this codebase already do the closest similar thing? That pattern is your default.
- Identify what you *don't* know — an unfamiliar dependency, an unclear data flow — and resolve it by reading, not by assuming.

## Write the plan down

Keep it short — a plan that takes longer to write than to obsolete is too long. It should name:

- The approach in one or two sentences, and the main alternative you rejected.
- The files to touch and roughly what changes in each.
- The order of changes, if order matters (structural change first, behavior second).
- The risks: what could this break, and where would that show up?

## Define verification up front

Before writing code, decide how you will prove it works: the command to run, the endpoint to hit, the test to add. If you cannot name the verification, you do not yet understand the task. This is the single highest-value line in the plan.

## Hold the plan loosely

- When implementation reveals the plan was wrong, update the plan — don't force the code to follow a broken map. Say what changed and why.
- Don't gold-plate: the plan defines done. Work beyond it is scope creep, however tempting.

## Non-negotiables

- Do not start a multi-file change without naming the files and the order.
- Do not write the plan after the code as documentation theater.
- Do not carry an invalidated plan forward silently.
- Do not plan past the point of usefulness — the plan serves the change, not the reverse.
