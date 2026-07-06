---
name: test-discipline
description: What makes a test worth having — test behavior not implementation, cover the case that motivated the change, mock sparingly. Use when writing tests, reviewing tests, or deciding what to test.
---

# Test discipline

Tests are not a quota to fill; they are executable claims about behavior. A good test fails when the behavior breaks, passes when it doesn't, and tells you what went wrong when it fails. Everything else follows from that.

## Test behavior, not implementation

- Assert on what the code *does* — outputs, state changes, observable effects — not on how it does it (which private method ran, in what order, with what internal arguments).
- A test that breaks on a refactor that preserved behavior is a bad test: it punishes exactly the maintenance work tests exist to enable.
- Name the test after the behavior it claims: `rejects_expired_tokens`, not `test_validate_2`.

## Cover the motivating case

- The first test for any change is the case that motivated it: the bug's reproduction, the feature's core promise. If the change is a fix, the test must fail without the fix — run it both ways once to prove it.
- Then the edges the change creates: the empty input, the boundary value, the error path, the concurrent caller — chosen because the changed code makes them reachable, not from a generic checklist.

## Mock sparingly

- Never mock the thing under test, and don't mock what you can use for real — pure functions, in-memory implementations, local files.
- Mock at system boundaries: the network, the clock, the payment provider. A test whose every collaborator is fake verifies your mocks agree with each other, not that the code works.
- If a test needs five mocks to instantiate the subject, that's design feedback about coupling — worth reporting, not muffling with more mocks.

## Make failures readable

- One behavior per test, so a failure names the broken behavior rather than "something in this 40-assertion test."
- Prefer assertions whose failure output shows the actual vs. expected values.
- A test the next engineer can't understand will be deleted or ignored the first time it fails inconveniently.

## Coverage is a byproduct, not a goal

Chasing a percentage produces assertion-free tests that execute lines without checking anything. Coverage is useful for finding *untested* code; it says nothing about whether the tested code is tested well.

## Non-negotiables

- Do not write a fix's test without seeing it fail against the unfixed code.
- Do not assert on implementation details a refactor would legitimately change.
- Do not mock the system under test.
- Do not delete or skip a failing test to make a suite green — that is falsifying the report.
