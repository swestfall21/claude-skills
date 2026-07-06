# Senior engineering skills for Claude

A portable pack of Claude skills — plain markdown skill folders — that encode senior software engineering behavior. The repo has two halves:

- **Fable-emulation skills**: instructions that capture Claude Fable 5's working style so older models (Opus, Sonnet) approximate it once Fable access ends. `fable-mode` is the capstone that adopts all six companion disciplines at once.
- **Senior engineering skills**: role modes (architect, staff engineer, lead developer, and others), operational guardrails (review gates, incident playbooks, launch readiness), and ready-made bundle presets that combine them for common work modes.

Each skill is independently loadable, and all of them are plain markdown, so they can be copied between machines or pasted into any agent tool's custom instructions.

## The skills

| Skill | What it encodes |
|---|---|
| `fable-mode` | Capstone — the full behavioral profile in one page. Invoke at session start. |
| `lead-with-outcome` | Answer-first reporting, complete final messages, readable prose over fragments. |
| `finish-the-turn` | Persistence: never end on a plan or promise; act without asking on reversible steps. |
| `truthful-reporting` | Faithful status: failures with output, skipped steps named, no hedging on verified work. |
| `surgical-questions` | Decide from request/code/convention and state the choice; ask only user-owned decisions. |
| `code-like-a-local` | Match codebase idiom and comment density; comments only for constraints; no drive-by edits. |
| `lean-tool-use` | Parallel independent calls, targeted reads, no redundant verification, subagent restraint. |
| `architect-mode` | Shape systems and boundaries with explicit trade-offs and durable design. |
| `staff-engineer-mode` | Set direction, create leverage, and influence across teams. |
| `lead-developer-mode` | Lead implementation work with clear execution, review, and delivery discipline. |
| `product-minded-engineer-mode` | Connect engineering work to user value, scope, and measurable outcomes. |
| `reliability-incident-mode` | Stabilize incidents, investigate root cause, and harden systems. |
| `security-minded-engineer-mode` | Build and review software with security as a first-class concern. |
| `run-guardrails-on-code-changes` | Enforce a strict pre-finish quality gate for code-change tasks, including tests, lint, and repo-specific checks. |
| `review-quality-gate` | Ensure reviews are substantive, actionable, and risk-aware before approval. |
| `decision-making-guardrails` | Force explicit trade-offs and clear recommendations for major decisions. |
| `incident-response-playbook` | Guide incident handling with stabilization, evidence, verification, and follow-up. |
| `migration-refactor-safety` | Make migrations and refactors safe, observable, and reversible. |
| `launch-readiness-gate` | Ensure a change is actually ready for launch before declaring release readiness. |
| `stakeholder-communication` | Improve status reporting, blockers, and cross-functional updates. |
| `senior-operating-system` | A capstone bundle that activates a coherent senior-engineering operating mode for delivery, architecture, leadership, reliability, or launch work. |
| `delivery-bundle` | A ready-made preset for everyday implementation, review, and delivery work. |
| `architecture-bundle` | A ready-made preset for architecture, design trade-offs, and system shaping. |
| `staff-engineering-bundle` | A ready-made preset for staff-level coordination, leverage, and cross-team alignment. |
| `reliability-bundle` | A ready-made preset for incidents, operational recovery, and hardening. |
| `product-delivery-bundle` | A ready-made preset for product-minded delivery with strong scope and launch discipline. |

## Ready-made bundle presets

These preset skill folders combine a small set of related skills into a single, reusable operating mode for common work types:

| Bundle preset | Best for |
|---|---|
| `delivery-bundle` | everyday implementation, bug fixes, and delivery work |
| `architecture-bundle` | architecture, system design, and major refactors |
| `staff-engineering-bundle` | staff-level coordination, influence, and cross-team alignment |
| `reliability-bundle` | incidents, operational stability, and recovery |
| `product-delivery-bundle` | product-focused delivery with clear scope and launch readiness |

In Claude Code, these are regular skill folders, so you can invoke them directly like `/delivery-bundle` or include them in your project instructions when you want a preset to be active.

## Installation

### Claude Code

Copy (or symlink) into your personal skills directory so Claude Code discovers them in every project:

```bash
git clone https://github.com/swestfall21/claude-skills.git
mkdir -p ~/.claude/skills
cp -r claude-skills/*/ ~/.claude/skills/
```

Or per-project: copy into `<project>/.claude/skills/`.

### Another machine or a different agent

These skills are stored as plain markdown skill folders, so they are easy to move to another machine or reuse in another environment.

```bash
git clone <your-repo-or-copy> ~/skills-repo
mkdir -p ~/.claude/skills
cp -r ~/skills-repo/*/ ~/.claude/skills/
```

If you are using a tool that does not support Claude-style skill discovery directly, the practical fallback is:

1. copy the skill folders to a location you can access from that environment,
2. paste the contents of the relevant SKILL.md files into that tool's custom instructions or prompt file, or
3. add the core behavior you want as a reusable system prompt or instruction block.

This repo is primarily designed for Claude Code style skill loading, so the exact path or mechanism will vary for tools like Kiro. For those environments, the same guidance still applies: bring the markdown files over and use them as custom instructions.

### Kiro / Opus setup example

If you want to use these skills in a Kiro-style setup that is configured with an Opus-class model, the simplest path is to treat the skill folders as reusable instruction packs.

1. Clone or copy this repository to a location you can access from the machine running Kiro.
2. Copy the skill folders you want to use into a local folder such as `~/skills`.
3. Add a short install snippet like this to your setup script or instructions:

```bash
mkdir -p ~/skills
cp -r path/to/claude-skills/delivery-bundle ~/skills/
```

4. In the tool's custom instructions, prompt file, or project instructions, add a short block like this:

```text
When the task is delivery-oriented, activate the delivery-bundle preset and follow its operating posture. For architecture-heavy work, use architecture-bundle. For incident work, use reliability-bundle. For staff-level coordination, use staff-engineering-bundle. For product-focused delivery, use product-delivery-bundle.
```

5. If the environment supports file-based instruction loading, point it at the SKILL.md files in those folders.
6. If it does not support that directly, paste the contents of the relevant SKILL.md files into your agent instructions or system prompt.

For Opus-class models, this is a good fit because the model can still benefit from the structure and defaults even if it is not using Claude Code's native skill discovery.

## Usage

- **Whole profile**: type `/fable-mode` at the start of a session, or add a line to your `~/.claude/CLAUDE.md`:

  ```
  At the start of each session, invoke the fable-mode skill and follow it for the whole session.
  ```

- **À la carte**: the individual skills have trigger-oriented descriptions, so the model can pull them in when relevant (e.g. `code-like-a-local` before editing, `lead-with-outcome` when summarizing). You can also invoke any directly: `/truthful-reporting`.

## Maintenance notes

- Written 2026-07 against Fable 5's observed behavior. As Opus/Sonnet versions improve, some rules become redundant — prune rather than accumulate.
- Instructions-in-context are weaker than trained behavior: expect the biggest gains on communication shape and honesty norms, smaller gains on judgment-heavy calls (when to ask, how deep to verify). Reinforce with corrections in-session; the model follows examples in the conversation more strongly than rules in a skill.
