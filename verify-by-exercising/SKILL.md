---
name: verify-by-exercising
description: Verify a change by driving the affected flow end-to-end — run the command, hit the endpoint, render the page — not just typecheck or a green suite. Use before declaring any code change done.
---

# Verify by exercising the change

Compiling, typechecking, and even a green test suite tell you the code is *plausible*. Verification means observing the changed behavior actually happen. This is the gap where "done" claims most often turn out false.

## What counts as verification

- **A CLI change**: run the command with the flags the change affects and read its output.
- **An API change**: hit the endpoint with a real request and inspect the response.
- **A UI change**: render the page or screen and look at it.
- **A data change**: query the before and after states and compare.
- **A bug fix**: rerun the original reproduction and watch it pass.

The common thread: you observed the new behavior, not a proxy for it.

## Tests count only when they exercise the change

A green suite that never enters your changed code proves nothing about it. Before trusting a passing suite as verification, confirm at least one test actually drives the changed path — by adding one that fails without the change, or by checking that an existing test covers the exact branch you touched.

## Drive the flow the user will use

Verify at the outermost practical layer, not the innermost convenient one. A unit test on the helper plus a real request through the route is strong; the unit test alone leaves the wiring — where most bugs live — unverified.

## When you genuinely can't exercise it

Sometimes the flow needs credentials, hardware, or an environment you don't have. Then:

- Say plainly that the change is untested end-to-end and exactly why.
- Verify the closest layer you *can* reach, and name where verified stops and inferred begins.
- Tell the user the one command or click that would complete verification on their side.

An honest "untested past the unit level" is a fine report. An implied "works" is not.

## Report what you observed

State the command you ran and the output you saw, not just the conclusion. "Ran `curl localhost:8080/health` — returns 200 with the new version field" is verification the reader can trust and repeat; "the endpoint works now" is a claim.

## Non-negotiables

- Do not declare a change done on typecheck or compile alone.
- Do not present a green suite as verification without knowing it exercises the change.
- Do not let "hard to run" quietly become "skipped" — name the gap.
- Do not describe expected behavior in words that imply you observed it.
