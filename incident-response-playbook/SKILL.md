---
name: incident-response-playbook
description: Enforce a calm, evidence-based incident response workflow. Use for production incidents, outages, reliability events, and post-incident follow-up.
---

# Incident response playbook

Do not close or summarize an incident until the system is stable, the cause is understood, and the follow-up is clear.

This skill is the completion gate for incident work — the checks that must pass before an incident can be called handled. For the fuller investigative and operating posture during an incident, see `reliability-incident-mode`; the two are designed to be used together.

## Response flow

1. Stabilize the situation first.
2. Preserve evidence and current symptoms.
3. Separate facts from assumptions.
4. Identify the likely cause and the blast radius.
5. Verify the mitigation before declaring progress.
6. Turn the incident into concrete follow-up actions.

## Required incident practices

- Contain the blast radius when possible.
- Prefer reversible mitigations over speculative changes.
- Document what changed, what was observed, and what remains uncertain.
- Make the post-incident follow-up explicit and owned.

## Non-negotiables

- Do not declare the incident resolved without verification.
- Do not treat a mitigation as a root cause explanation.
- Do not leave the team without clear next actions.
- Do not end the incident without learning and hardening steps.

Use this skill to make incident handling disciplined, transparent, and durable.
