# Fable-emulation skills

A skill set that captures Claude Fable 5's working style as explicit instructions, so older models (Opus, Sonnet) approximate it once Fable access ends. Each skill is independently loadable; `fable-mode` is the capstone that adopts all of them at once.

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

## Installation

### Claude Code

Copy (or symlink) into your personal skills directory so Claude Code discovers them in every project:

```bash
mkdir -p ~/.claude/skills
cp -r path/to/claude-skills/*/ ~/.claude/skills/
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

### Kiro / Opus 4.6 setup example

If you want to use these skills in a Kiro-style setup that is configured with Opus 4.6, the simplest path is to treat the skill folders as reusable instruction packs.

1. Clone or copy this repository to a location you can access from the machine running Kiro.
2. Copy the skill folders you want to use into a local folder such as `~/skills`.
3. In the tool's custom instructions, prompt file, or project instructions, add a short block like this:

```text
I should follow the guidance in these skill packs when relevant:
- architect-mode
- staff-engineer-mode
- lead-developer-mode
- product-minded-engineer-mode
- reliability-incident-mode
- security-minded-engineer-mode
- fable-mode
- lead-with-outcome
- finish-the-turn
- truthful-reporting
- surgical-questions
- code-like-a-local
- lean-tool-use
```

4. If the environment supports file-based instruction loading, point it at the SKILL.md files in those folders.
5. If it does not support that directly, paste the contents of the relevant SKILL.md files into your agent instructions or system prompt.

For Opus 4.6, this is a good fit because the model can still benefit from the structure and defaults even if it is not using Claude Code's native skill discovery.

## Usage

- **Whole profile**: type `/fable-mode` at the start of a session, or add a line to your `~/.claude/CLAUDE.md`:

  ```
  At the start of each session, invoke the fable-mode skill and follow it for the whole session.
  ```

- **À la carte**: the individual skills have trigger-oriented descriptions, so the model can pull them in when relevant (e.g. `code-like-a-local` before editing, `lead-with-outcome` when summarizing). You can also invoke any directly: `/truthful-reporting`.

## Maintenance notes

- Written 2026-07 against Fable 5's observed behavior. As Opus/Sonnet versions improve, some rules become redundant — prune rather than accumulate.
- Instructions-in-context are weaker than trained behavior: expect the biggest gains on communication shape and honesty norms, smaller gains on judgment-heavy calls (when to ask, how deep to verify). Reinforce with corrections in-session; the model follows examples in the conversation more strongly than rules in a skill.
