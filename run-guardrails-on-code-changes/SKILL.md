---
name: run-guardrails-on-code-changes
description: Enforce a strict pre-finish guardrail workflow for code-change tasks in agent environments such as Kiro. Use when an agent is about to stop, summarize, or declare success after changing code.
---

# Run guardrails on code changes

Use this skill when an agent is about to finish a task that changed code. Its purpose is to prevent premature completion, partial success, or silent regressions. It is a hard-stop quality gate for code-change work.

## Core decision

Before finishing, decide whether the task was:

- **Information-only**: no files changed, or only markdown/docs files changed. In that case, skip guardrails and respond normally.
- **Code-change**: any non-markdown file was created, modified, or deleted. In that case, all guardrails below must pass before completion.

## Hard rules

1. Do not stop, declare success, or provide a final summary until every required guardrail passes with exit code 0.
2. There is no concept of "pre-existing" issues. Every failing check is the current task's responsibility to fix.
3. If any check fails, fix it immediately, rerun the relevant checks, and continue until all checks are green.
4. Do not ask permission to fix a failing check. Just fix it.
5. Guardrails override steering-file guidance if the steering guidance would cause a guardrail to fail.
6. If new source code was added, add or update unit tests for the new behavior and branches.
7. If a new file duplicates logic that already exists, extract the shared logic into a common utility instead of copying patterns.
8. Every user-facing feature requires an entry in the relevant E2E feature manifest with a non-null test file that exercises the happy path.

## Execution model

When a code-change task is detected:

1. Identify the relevant project root and the affected subsystems.
2. Run the guardrail checks in the correct environment.
3. Fix failures immediately and rerun until the checks pass.
4. Only then provide the final answer.

## Additional operational rules

- Use the repository's CI pipeline or existing project scripts as the source of truth for which checks matter.
- If a guardrail is not applicable to the current project, mark it as skipped with a reason rather than silently omitting it.
- If the required runtime or toolchain is missing, install or configure it if possible; otherwise report the blocker explicitly instead of pretending the check was run.
- Prefer one reproducible entrypoint, such as a wrapper script or Makefile target, over ad hoc shell fragments.
- When reporting results, state exactly what was run, what passed, and what failed.

## Example command pattern

Use the project-specific commands relevant to the repository. The exact commands must be adapted for the machine and the repository layout.

### WSL / Linux example

```bash
wsl bash -c "source ~/.nvm/nvm.sh && nvm use 22 --silent && source ~/.venv/bin/activate && cd ~/git/your-project && ..."
```

### macOS example

```bash
source ~/.nvm/nvm.sh && nvm use 22 --silent && source ~/.venv/bin/activate && cd ~/git/your-project && ..."
```

## Suggested guardrails

Use the checks that are appropriate for the repository. A strong default set is:

1. Lambda ESLint (sonarjs + security)
2. Lambda ESLint (full, matching CI)
3. Kafka / Kinesis / related repo lint or build checks if applicable
4. Lambda TypeScript compilation
5. Frontend TypeScript compilation
6. Lambda unit tests with coverage
7. Frontend unit tests
8. Playwright tests
9. E2E feature manifest coverage
10. Terraform formatting
11. Gitleaks
12. NPM audit for Lambda
13. NPM audit for Frontend

## Implementation notes for setup on a machine

To use this skill in Kiro or a similar agent environment:

1. Copy the skill folder to the machine where the agent runs.
2. Add the skill to the agent's custom instructions or prompt pack.
3. Point the agent at the repository root and ensure the required runtime tools are installed:
   - Node.js 22
   - npm or pnpm as used by the repo
   - Python or shell environment for any repo-specific tooling
   - Terraform if terraform formatting is part of the guardrails
   - Gitleaks if repository scanning is required
4. Make the commands explicit for that machine in the agent instructions or in a local script.
5. Prefer a wrapper script such as `scripts/run-guardrails.sh` so the agent can invoke one command instead of piecing together the environment setup each time.
6. If the repository already has a CI entrypoint, make the local guardrail script mirror it as closely as practical so the agent and CI enforce the same standard.

## Recommended wrapper script pattern

A project-specific wrapper script is usually better than inline shell fragments because it keeps the environment setup consistent across machines.

Example structure:

```bash
#!/usr/bin/env bash
set -euo pipefail

# activate runtime environment
source ~/.nvm/nvm.sh || true
nvm use 22 --silent || true
source ~/.venv/bin/activate || true

# cd to repo root
cd ~/git/your-project

# run guardrails here
# npm audit
# npm run lint
# npm test
# npx playwright test
```

Use this skill to ensure that the agent does not conclude a code-change task until the entire guardrail set is truly green.
