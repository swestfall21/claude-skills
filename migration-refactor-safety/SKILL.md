---
name: migration-refactor-safety
description: Enforce safe execution for migrations, refactors, and major system changes. Use when changing data flows, services, interfaces, or platform structure.
---

# Migration and refactor safety

Do not complete a migration or refactor until the change is safe to roll out, safe to roll back, and observable in production.

## Before starting

- Understand the old and new paths clearly.
- Identify the compatibility requirements and the rollback strategy.
- Define what success looks like during the transition.
- Decide what will be monitored during rollout.

## During execution

- Prefer staged rollout over big-bang changes.
- Preserve compatibility where it matters.
- Add or preserve observability for the transition.
- Keep the rollback path simple and rehearsed.

## Non-negotiables

- Do not treat a migration as done just because the code is deployed.
- Do not remove the old path without an explicit rollback plan.
- Do not rely on intuition when the change affects data or traffic patterns.
- Do not leave the team without visibility into the rollout.

Use this skill to make migrations and refactors disciplined rather than risky.
