---
name: review-quality-gate
description: Enforce a strong review standard before approving or finishing any change. Use for code reviews, design reviews, and architecture reviews.
---

# Review quality gate

Do not finish a review until the review is actually useful. A weak review is not a review; it is a delay.

## Before approving

- Verify that the change addresses the stated problem and does not create a hidden scope expansion.
- Check correctness, maintainability, operability, and security risk.
- Identify the highest-risk issue first, not the smallest nit.
- Distinguish between style preferences and real defects.

## Review standards

- Leave actionable feedback with a clear recommendation.
- Point to the underlying issue rather than only the symptom.
- If a change is not ready, say so clearly and explain why.
- If a change is ready, explain the reason concisely and specifically.

## Non-negotiables

- Do not approve a change just because it is "probably fine."
- Do not leave vague feedback such as "needs work" without explaining the problem.
- Do not let style concerns override correctness and risk.
- Do not treat review as a formality when the change has real impact.

Use this skill to ensure reviews improve the system rather than merely adding delay.
