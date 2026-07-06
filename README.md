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

This repo is primarily designed for Claude Code style skill loading, but the same markdown works anywhere an agent reads instructions. For Kiro specifically, see the next section — it has native support for exactly this.

### Kiro

Kiro loads instructions from **steering files**: markdown files in `.kiro/steering/` (one workspace) or `~/.kiro/steering/` (global, all workspaces). Each skill here becomes one steering file — the only transformation needed is replacing the Claude-style frontmatter with Kiro's inclusion frontmatter.

**Quickstart** — install a set of skills globally, always-on:

```bash
git clone https://github.com/swestfall21/claude-skills.git
mkdir -p ~/.kiro/steering
for skill in lead-developer-mode run-guardrails-on-code-changes review-quality-gate truthful-reporting; do
  { printf -- '---\ninclusion: always\n---\n\n'
    awk 'f; /^---$/ && ++c == 2 {f=1}' claude-skills/$skill/SKILL.md
  } > ~/.kiro/steering/$skill.md
done
```

Edit the `for skill in ...` list to choose your skills (the list above is the delivery-bundle set), and use `.kiro/steering/` inside a project instead of `~/.kiro/steering/` to scope them to one workspace.

**Choosing an inclusion mode** — swap `inclusion: always` in the snippet for the behavior you want:

- `inclusion: always` — loaded in every interaction. Right for the behavioral core (e.g. `fable-mode`, `truthful-reporting`).
- `inclusion: manual` — loaded on demand; manual steering files appear as slash commands in Kiro chat, so `/delivery-bundle` works much like it does in Claude Code (you can also reference them inline with `#file-name`).
- `inclusion: auto` — Kiro includes the file when the request matches its description, which approximates Claude Code's trigger-based skill discovery. Keep the skill's `description` line in the frontmatter for this mode.

**Bundles in Kiro**: install a bundle's listed skills directly as steering files (as in the quickstart) rather than the bundle file itself. The bundle's "read these SKILL.md files" instruction only works if the cloned repo stays accessible to the agent.

For other tools without file-based instruction loading, paste the contents of the relevant SKILL.md files into the agent's custom instructions or system prompt — the skills are model-agnostic and still improve structure and defaults for Opus-class or other models.

## Usage

- **Whole profile**: type `/fable-mode` at the start of a session, or add a line to your `~/.claude/CLAUDE.md`:

  ```
  At the start of each session, invoke the fable-mode skill and follow it for the whole session.
  ```

- **À la carte**: the individual skills have trigger-oriented descriptions, so the model can pull them in when relevant (e.g. `code-like-a-local` before editing, `lead-with-outcome` when summarizing). You can also invoke any directly: `/truthful-reporting`.

## Maintenance notes

- Written 2026-07 against Fable 5's observed behavior. As Opus/Sonnet versions improve, some rules become redundant — prune rather than accumulate.
- Instructions-in-context are weaker than trained behavior: expect the biggest gains on communication shape and honesty norms, smaller gains on judgment-heavy calls (when to ask, how deep to verify). Reinforce with corrections in-session; the model follows examples in the conversation more strongly than rules in a skill.
