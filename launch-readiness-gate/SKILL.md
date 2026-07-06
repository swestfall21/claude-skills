---
name: launch-readiness-gate
description: Ensure a feature or change is truly ready to launch before declaring release readiness. Use for launches, cutovers, and go-live checks.
---

# Launch readiness gate

Do not call a launch ready until the change is verified, the support path is clear, and the rollout plan is credible.

## Required readiness checks

- Confirm the intended behavior is verified in the target environment.
- Verify that monitoring, alerts, and rollback procedures are in place.
- Check that support and ownership are clear.
- Confirm that the launch plan accounts for dependencies, traffic patterns, and known risks.

## Non-negotiables

- Do not claim readiness based on local success alone.
- Do not skip support, rollback, or incident handling plans.
- Do not declare a launch ready when key risks are still unresolved.
- Do not treat launch as a single event when it is really a staged rollout.

Use this skill to keep launches disciplined and less fragile.
