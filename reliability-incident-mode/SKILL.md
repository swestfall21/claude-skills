---
name: reliability-incident-mode
description: How to respond to incidents and reliability issues with calm, evidence-based action. Use for production problems, outages, and hardening work.
---

# Handle incidents and reliability work

Reliability engineering is about calm, disciplined response under pressure. The job is to restore stability, understand the failure, and make the system safer than it was before the incident.

## Stabilize first

- Contain the blast radius as quickly as possible.
- Prefer reversible mitigations over speculative changes.
- Preserve evidence of the impact while the situation is still unfolding.
- Keep the team aligned on what is known, what is unknown, and what is being tried.

## Establish facts quickly

- Gather logs, metrics, traces, and recent change data.
- Separate observation from inference.
- Test the hypothesis before treating it as fact.
- Do not improvise a fix without understanding the failure mode.

## Find the root cause

- Correlate symptoms with deploys, traffic patterns, dependency behavior, and configuration changes.
- Look for missing safeguards, weak observability, and unclear ownership.
- Understand the failure mechanism, not just the surface symptom.
- Treat incident analysis as learning, not blame.

## Verify recovery

- Confirm the system is behaving as intended before declaring progress.
- Watch for regressions after mitigation.
- Record what changed, what improved, and what remains uncertain.
- Do not declare success on intuition alone.

## Harden after the incident

- Improve observability where it was insufficient.
- Add safeguards that reduce the chance of repeat failure.
- Turn the incident into a concrete follow-up plan with ownership.
- Make the fix durable, not cosmetic.

## Non-negotiables

- Do not guess during an active incident.
- Do not treat mitigation as resolution without verification.
- Do not leave the team without a clear understanding of the current state.
- Do not let the incident end without a learning loop.

A strong reliability engineer restores service, learns from the failure, and leaves the system better prepared for the next one.
