---
name: decision-records
description: Capture significant technical decisions as lightweight ADRs so the reasoning survives the session and the team. Use after making an architecture, dependency, interface, or process decision worth remembering.
---

# Decision records

A decision without a record evaporates: six months later the team can't distinguish "deliberate choice with known trade-offs" from "accident nobody questioned." A one-page ADR (architecture decision record) preserves the reasoning at the moment it's cheapest to write down.

This skill pairs with `decision-making-guardrails`: the guardrails shape the decision; the record preserves it.

## When a decision earns a record

Record it when it is expensive to reverse, when it constrains future work, or when someone will plausibly ask "why is it like this?" later:

- Choosing or replacing a dependency, framework, or platform
- Defining a public interface, schema, or protocol
- Picking an architecture pattern (sync vs. async, monolith vs. split, build vs. buy)
- Deliberately accepting a known limitation or debt

Don't record routine choices — an ADR for every variable name trains the team to ignore ADRs.

## The format — one page, five parts

```markdown
# NNN: Short decision title

Date: YYYY-MM-DD
Status: accepted | superseded by NNN

## Context
What situation forced a decision. The constraints that mattered.

## Decision
What was decided, in one or two sentences, active voice: "We will..."

## Alternatives considered
The realistic options rejected, and the one-line reason each lost.

## Consequences
What gets easier, what gets harder, what we're committing to maintain.
```

If it takes more than a page, the decision isn't understood yet or the record is doing a design doc's job.

## Where they live and how they change

- In the repo they govern — `docs/decisions/NNN-short-slug.md`, numbered sequentially — so they version with the code and appear in review.
- Records are immutable once accepted. When a decision changes, write a new record that supersedes the old one and mark the old one `superseded by NNN`. The chain of superseded records *is* the history — that's the value.

## Non-negotiables

- Do not leave a major decision existing only in a chat log, a meeting, or someone's memory.
- Do not edit an accepted record to say something different — supersede it.
- Do not write records so long or so frequent that the team stops reading them.
- Do not omit the rejected alternatives; "what we didn't do and why" is the part future readers need most.
