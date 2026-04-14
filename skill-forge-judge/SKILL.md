---
name: skill-forge-judge
description: Evaluate any LLM prompt (SKILL.md, CLAUDE.md, system prompts, bash guidance) for quality: grouped dimensional scoring with letter grade and skill-forge-hitl-compatible findings list. Triggers: judge/review/audit/score/evaluate this skill or prompt.
---

# Skill Forge Judge

Evaluate any LLM-consumed prompt against quality standards, focused on knowledge delta, instruction clarity, and practical usability.

---

## Core Philosophy

### What is a Prompt?

Any text consumed by an LLM to modify its behavior. Includes:

- **Skills** (SKILL.md): Hot-swap domain expertise
- **CLAUDE.md / System prompts**: Behavioral framing, constraints, workflow rules
- **Bash/Shell guidance**: Environment-specific anti-patterns and constraints

> **Good Prompt = Expert-only Knowledge − What Claude Already Knows**

Restating defaults is token waste.

### Three Types of Knowledge

| Type | Definition | Treatment |
|------|------------|-----------|
| **Expert** | Claude genuinely doesn't know this | Must keep — this is the value |
| **Activation** | Claude knows but may not think of | Keep if brief — serves as reminder |
| **Redundant** | Claude definitely knows this | Delete — wastes tokens |

Good prompt: >70% Expert, <20% Activation, <10% Redundant.


## Evaluation Dimensions

Dimensions are grouped. Universal dimensions always apply. Type-specific modules apply based on what the prompt is. Multiple groups can apply to a single prompt.

**Final grade = total score / total applicable points (as %)**

| Grade | % | Meaning |
|-------|---|---------|
| A | 90%+ | Excellent — production-ready |
| B | 80–89% | Good — minor improvements needed |
| C | 70–79% | Adequate — clear improvement path |
| D | 60–69% | Below average — significant issues |
| F | <60% | Poor — needs fundamental redesign |

### Group U: Universal (80 pts) — always scored

**MANDATORY — READ [`references/universal-dimensions.md`](references/universal-dimensions.md)**

| ID | Dimension | Pts |
|----|-----------|-----|
| U1 | Knowledge/Instruction Delta | 20 |
| U2 | Mindset + Procedures | 15 |
| U3 | Anti-Pattern Quality | 15 |
| U4 | Freedom Calibration | 15 |
| U5 | Practical Usability | 15 |

### Group S: Skill Module (40 pts) — SKILL.md targets only

**MANDATORY — READ [`references/skill-dimensions.md`](references/skill-dimensions.md)**

| ID | Dimension | Pts |
|----|-----------|-----|
| S1 | Specification Compliance | 15 |
| S2 | Progressive Disclosure | 15 |
| S3 | Pattern Recognition | 10 |

### Group C: CLAUDE.md / System Prompt Module (40 pts) — prompts that govern LLM behavior settings

**MANDATORY — READ [`references/claude-md-dimensions.md`](references/claude-md-dimensions.md)**

| ID | Dimension | Pts |
|----|-----------|-----|
| C1 | Behavioral Clarity | 15 |
| C2 | Scope Definition | 15 |
| C3 | Structural Organization | 10 |

### Group B: Bash/Shell Module (30 pts) — prompts that contain shell/CLI guidance

**MANDATORY — READ [`references/bash-dimensions.md`](references/bash-dimensions.md)**

| ID | Dimension | Pts |
|----|-----------|-----|
| B1 | Rule Specificity & WHY | 10 |
| B2 | Anti-Pattern Coverage | 10 |
| B3 | Scope & Exceptions | 10 |

---

## Evaluation Protocol

### Step 0: Detect Prompt Type

Read the target and identify which groups apply:

```
[ ] Is it a SKILL.md file?              → Score U + S. Do NOT load claude-md-dimensions.md or bash-dimensions.md.
                                          MANDATORY: WebFetch https://agentskills.io/specification before scoring S1.
[ ] Is it a CLAUDE.md / system prompt?  → Score U + C. Do NOT load skill-dimensions.md.
[ ] Does it contain bash/shell rules?   → Also score B. Load bash-dimensions.md.
[ ] Is it something else?               → Score U only. Do NOT load any type-specific reference.
```

Multiple groups can apply (e.g. a CLAUDE.md with bash guidance → U + C + B).

**Edge cases**:
- SKILL.md that also contains bash guidance → U + S + B
- A referenced sub-file (e.g. `references/bash.md`, not a root prompt) → U only; note "sub-file, not root prompt" in report
- Ambiguous type (could be CLAUDE.md or skill) → score both C and S groups; note the ambiguity in the Summary

### Step 1: First Pass — Knowledge Delta Scan

Read completely. For each section ask:
> "Does Claude already know this?"

Mark each section: **[E] Expert** | **[A] Activation** | **[R] Redundant**

Calculate ratio E:A:R. Target: >70% Expert.

### Step 2: Structure Analysis

```
[ ] Identify prompt type(s) and applicable groups
[ ] Check structure and length
[ ] List any reference or auxiliary files
[ ] Note any loading/trigger mechanisms (Skills only)
```

### Step 3: Score Each Applicable Dimension

**Load the reference file for each applicable group before scoring.**

For each dimension:
1. Find specific evidence (quote relevant lines)
2. Assign score with one-line justification
3. Note specific improvements if score < max

### Step 4: Calculate Score & Grade

```
Total = sum of all applicable dimension scores
Max   = sum of all applicable dimension maxes
Grade = Total / Max as percentage → apply grade scale
```

### Step 5: Generate Report

```markdown
# Prompt Evaluation Report: [Name]

## Executive Summary
[2–3 sentences. State the overall verdict, one top strength, one top weakness. No scores or tables here — prose only. Written for someone who will read only this section.]

## Summary
- **Type**: [Skill / CLAUDE.md / System Prompt / Other] + applicable groups
- **Score**: X / Y (Z%)
- **Grade**: [A/B/C/D/F]
- **Knowledge Ratio**: E:A:R = X:Y:Z
- **Verdict**: [One sentence assessment]

## Group Scores

| Group | Score | Max | % |
|-------|-------|-----|---|
| U: Universal | | 80 | |
| S: Skill | | 40 | | ← if applicable
| C: CLAUDE.md | | 40 | | ← if applicable
| B: Bash/Shell | | 30 | | ← if applicable
| **Total** | | | |

## Dimension Scores

Include only rows for groups detected in Step 0. Omit rows for groups that don't apply.

| ID | Dimension | Score | Max | Notes |
|----|-----------|-------|-----|-------|
| U1 | Knowledge/Instruction Delta | | 20 | |
| U2 | Mindset + Procedures | | 15 | |
| U3 | Anti-Pattern Quality | | 15 | |
| U4 | Freedom Calibration | | 15 | |
| U5 | Practical Usability | | 15 | |
| S1 | Specification Compliance | | 15 | Group S: SKILL.md only |
| S2 | Progressive Disclosure | | 15 | Group S: SKILL.md only |
| S3 | Pattern Recognition | | 10 | Group S: SKILL.md only |
| C1 | Behavioral Clarity | | 15 | Group C: CLAUDE.md / system prompts only |
| C2 | Scope Definition | | 15 | Group C: CLAUDE.md / system prompts only |
| C3 | Structural Organization | | 10 | Group C: CLAUDE.md / system prompts only |
| B1 | Rule Specificity & WHY | | 10 | Group B: when shell guidance present |
| B2 | Anti-Pattern Coverage | | 10 | Group B: when shell guidance present |
| B3 | Scope & Exceptions | | 10 | Group B: when shell guidance present |

## Critical Issues
[Must-fix problems that significantly impact effectiveness]

## Detailed Analysis
[For each dimension scoring below 80%, provide:
- What's missing or problematic
- Specific evidence with line numbers
- Concrete suggestions for improvement]

## Numbered Improvements
1. [Highest impact improvement with specific guidance]
2. [Second priority]
3. ...

(skill-forge-hitl-compatible — invoke /skill-forge-hitl to step through each item.)
```

---

## Common Failure Patterns

**MANDATORY — READ [`references/failure-patterns.md`](references/failure-patterns.md)**

---

## Quick Reference Checklist

```
┌─────────────────────────────────────────────────────────────────────────┐
│  PROMPT EVALUATION QUICK CHECK                                          │
├─────────────────────────────────────────────────────────────────────────┤
│  Universal (all types)                                                  │
│    [ ] Knowledge delta: no basics, has expert decision trees            │
│    [ ] Mindset: thinking patterns + domain procedures                   │
│    [ ] Anti-patterns: specific NEVER list with WHY                      │
│    [ ] Freedom: calibrated to task fragility                            │
│    [ ] Usability: decision trees, actionable, edge cases covered        │
│                                                                         │
│  Skills (SKILL.md)                                                      │
│    [ ] Description: answers WHAT, WHEN, has KEYWORDS                   │
│    [ ] Progressive disclosure: <500 lines, loading triggers             │
│    [ ] Pattern: follows Mindset/Navigation/Philosophy/Process/Tool      │
│                                                                         │
│  CLAUDE.md / System Prompts                                             │
│    [ ] Behavioral clarity: unambiguous, non-contradictory               │
│    [ ] Scope: governs only what needs governing                         │
│    [ ] Structure: scannable, logically ordered                          │
│                                                                         │
│  Bash/Shell Guidance                                                    │
│    [ ] Rules specific: name commands/patterns, not vague warnings       │
│    [ ] Anti-patterns cover real failure modes with WHY                  │
│    [ ] Scope: clear when rules apply, exceptions noted                  │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Extending skill-forge-judge

To add a new evaluation group, **MANDATORY — READ [`references/extending-groups.md`](references/extending-groups.md)** before proposing any new group. Do NOT load this file during a normal evaluation run.

---

## Self-Application

skill-forge-judge can and should evaluate itself. The criteria must be self-consistent — if skill-forge-judge can't score well against its own rubric, the rubric is wrong.

**Applicable groups**: skill-forge-judge is a SKILL.md with no bash guidance → U + S (120 pts max).

**Expected score**: ≥B (80%+, ≥96/120). A score below B indicates the rubric has drifted from its own standards and the lowest-scoring dimensions should be revisited. A score of A (90%+) on self-evaluation is a warning sign — it may mean the criteria were written to fit the evaluator rather than the other way around.

**Known limitation**: self-evaluation can be gamed by writing criteria the evaluator happens to satisfy. When evaluating skill-forge-judge itself, pay extra attention to whether dimensions capture genuine expert knowledge vs. formalizing what any thoughtful evaluator would do anyway.

---

## NEVER Do When Evaluating

- **NEVER** give high scores just because it "looks professional" or is well-formatted — formatting is cheap; rewarding it masks content gaps and trains authors to polish instead of improve
- **NEVER** ignore token waste — redundant content dilutes expert signal and teaches authors that padding is acceptable; deduct consistently to create the right incentive
- **NEVER** let length impress you — a 500-line prompt with 80% activation content is worse than a 50-line one with pure expert knowledge; length is effort, not value
- **NEVER** skip mentally testing decision trees — plausible-looking trees often have unreachable branches or missing cases that only surface when traced
- **NEVER** forgive explaining basics with "but it provides helpful context" — it sets a precedent that activation content earns tokens; future versions accumulate more
- **NEVER** overlook missing anti-patterns — absence of a NEVER list usually means the author hasn't hit the failure modes yet, not that they don't exist
- **NEVER** assume all procedures are valuable — generic procedures (open, edit, save) inflate U2 scores without adding knowledge delta
- **NEVER** undervalue the description field for Skills — it is the only thing the agent sees before deciding whether to load the skill; poor description = skill never activates regardless of content quality
- **NEVER** compare percentage scores across evaluations without checking which groups were scored — U+S (120 pts) and U+C+B (150 pts) are different denominators; the percentages are comparable, the raw scores are not
