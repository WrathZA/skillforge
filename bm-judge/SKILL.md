---
name: bm-judge
description: Evaluate Agent Skill design quality against official specifications and best practices. Use when reviewing, auditing, or improving SKILL.md files and skill packages. Provides multi-dimensional scoring (120 points across 8 dimensions) and actionable improvement suggestions in a numbered findings list. Trigger phrases: "review this skill", "judge this skill", "audit this skill", "score this skill", "evaluate this SKILL.md".
---

# BM Judge

Evaluate Agent Skills against official specifications and patterns, focused on knowledge delta, structure, and practical usability.

---

## Core Philosophy

### What is a Skill?

A Skill is NOT a tutorial. A Skill is a **knowledge externalization mechanism**.

Traditional AI knowledge is locked in model parameters. To teach new capabilities:
```
Traditional: Collect data → GPU cluster → Train → Deploy new version
Cost: $10,000 - $1,000,000+
Timeline: Weeks to months
```

Skills change this:
```
Skill: Edit SKILL.md → Save → Takes effect on next invocation
Cost: $0
Timeline: Instant
```

This is the paradigm shift from "training AI" to "educating AI" — like a hot-swappable LoRA adapter that requires no training. You edit a Markdown file in natural language, and the model's behavior changes.

### The Core Formula

> **Good Skill = Expert-only Knowledge − What Claude Already Knows**

A Skill's value is measured by its **knowledge delta** — the gap between what it provides and what the model already knows.

- **Expert-only knowledge**: Decision trees, trade-offs, edge cases, anti-patterns, domain-specific thinking frameworks
- **What Claude already knows**: Basic concepts, standard library usage, common programming patterns, general best practices

When a Skill explains "what is PDF" or "how to write a for-loop", it's compressing knowledge Claude already has. This is **token waste**.

### Tool vs Skill

| Concept | Essence | Function | Example |
|---------|---------|----------|---------|
| **Tool** | What model CAN do | Execute actions | bash, read_file, write_file, WebSearch |
| **Skill** | What model KNOWS how to do | Guide decisions | PDF processing, MCP building, frontend design |

**The equation**:
```
General Agent + Excellent Skill = Domain Expert Agent
```

### Three Types of Knowledge in Skills

When evaluating, categorize each section:

| Type | Definition | Treatment |
|------|------------|-----------|
| **Expert** | Claude genuinely doesn't know this | Must keep — this is the Skill's value |
| **Activation** | Claude knows but may not think of | Keep if brief — serves as reminder |
| **Redundant** | Claude definitely knows this | Should delete — wastes tokens |

---

## Evaluation Dimensions (120 points total)

**MANDATORY — READ [`references/generic-dimensions.md`](references/generic-dimensions.md)** before scoring D1–D8. That file contains the full scoring rubrics, examples, and criteria for each dimension.

| Dimension | Max | What it measures |
|-----------|-----|------------------|
| D1: Knowledge Delta | 20 | Does the Skill add genuine expert knowledge? |
| D2: Mindset + Procedures | 15 | Expert thinking patterns + domain-specific workflows |
| D3: Anti-Pattern Quality | 15 | Effective NEVER lists with WHY |
| D4: Specification Compliance | 15 | Frontmatter validity, description quality (WHAT/WHEN/KEYWORDS) |
| D5: Progressive Disclosure | 15 | Content layering, loading triggers, line count |
| D6: Freedom Calibration | 15 | Specificity matched to task fragility |
| D7: Pattern Recognition | 10 | Follows an established skill design pattern |
| D8: Practical Usability | 15 | Decision trees, actionability, edge case coverage |

---

## Evaluation Protocol

### Step 1: First Pass — Knowledge Delta Scan

Read SKILL.md completely and for each section ask:
> "Does Claude already know this?"

Mark each section as:
- **[E] Expert**: Claude genuinely doesn't know this — value-add
- **[A] Activation**: Claude knows but brief reminder is useful — acceptable
- **[R] Redundant**: Claude definitely knows this — should be deleted

Calculate rough ratio: E:A:R
- Good Skill: >70% Expert, <20% Activation, <10% Redundant
- Mediocre Skill: 40-70% Expert, high Activation
- Bad Skill: <40% Expert, high Redundant

### Step 2: Structure Analysis

```
[ ] Check frontmatter validity
[ ] Count total lines in SKILL.md
[ ] List all reference files and their sizes
[ ] Identify which pattern the Skill follows
[ ] Check for loading triggers (if references exist)
```

### Step 3: Score Each Dimension

**MANDATORY — READ [`references/generic-dimensions.md`](references/generic-dimensions.md)** before scoring.

For each of the 8 dimensions:
1. Find specific evidence (quote relevant lines)
2. Assign score with one-line justification
3. Note specific improvements if score < max

### Step 4: Calculate Total & Grade

```
Total = D1 + D2 + D3 + D4 + D5 + D6 + D7 + D8
Max = 120 points
```

**Grade Scale**:
| Grade | Percentage | Points | Meaning |
|-------|------------|--------|---------|
| A | 90%+ | 108+ | Excellent — production-ready expert Skill |
| B | 80-89% | 96-107 | Good — minor improvements needed |
| C | 70-79% | 84-95 | Adequate — clear improvement path |
| D | 60-69% | 72-83 | Below Average — significant issues |
| F | <60% | <72 | Poor — needs fundamental redesign |

### Step 5: Generate Report

```markdown
# Skill Evaluation Report: [Skill Name]

## Summary
- **Total Score**: X/120 (X%)
- **Grade**: [A/B/C/D/F]
- **Pattern**: [Mindset/Navigation/Philosophy/Process/Tool]
- **Knowledge Ratio**: E:A:R = X:Y:Z
- **Verdict**: [One sentence assessment]

## Dimension Scores

| Dimension | Score | Max | Notes |
|-----------|-------|-----|-------|
| D1: Knowledge Delta | X | 20 | |
| D2: Mindset vs Mechanics | X | 15 | |
| D3: Anti-Pattern Quality | X | 15 | |
| D4: Specification Compliance | X | 15 | |
| D5: Progressive Disclosure | X | 15 | |
| D6: Freedom Calibration | X | 15 | |
| D7: Pattern Recognition | X | 10 | |
| D8: Practical Usability | X | 15 | |

## Critical Issues
[List must-fix problems that significantly impact the Skill's effectiveness]

## Numbered Improvements
1. [Highest impact improvement with specific guidance]
2. [Second priority improvement]
3. ...

(This list is bm-hitl-compatible — invoke /bm-hitl to step through each item.)

## Detailed Analysis
[For each dimension scoring below 80%, provide:
- What's missing or problematic
- Specific examples from the Skill (with line numbers)
- Concrete suggestions for improvement]
```

---

## Common Failure Patterns

**MANDATORY — READ [`references/failure-patterns.md`](references/failure-patterns.md)** for all failure patterns before generating the report.

---

## Quick Reference Checklist

```
┌─────────────────────────────────────────────────────────────────────────┐
│  SKILL EVALUATION QUICK CHECK                                           │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│    [ ] Knowledge delta: no basics, has expert decision trees            │
│    [ ] Mindset: thinking patterns + domain procedures                   │
│    [ ] Anti-patterns: specific NEVER list with WHY                      │
│    [ ] Description: answers WHAT, WHEN, has KEYWORDS                   │
│    [ ] Progressive disclosure: <500 lines, loading triggers             │
│    [ ] Freedom: calibrated to task fragility                            │
│    [ ] Pattern: follows Mindset/Navigation/Philosophy/Process/Tool      │
│    [ ] Usability: decision trees, actionable, edge cases covered        │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## The Meta-Question

When evaluating any Skill, always return to this fundamental question:

> **"Would an expert in this domain, looking at this Skill, say:**
> **'Yes, this captures knowledge that took me years to learn'?"**

If the answer is yes → the Skill has genuine value.
If the answer is no → it's compressing what Claude already knows.

## NEVER Do When Evaluating

- **NEVER** give high scores just because it "looks professional" or is well-formatted
- **NEVER** ignore token waste — every redundant paragraph should result in deduction
- **NEVER** let length impress you — a 43-line Skill can outperform a 500-line Skill
- **NEVER** skip mentally testing the decision trees — do they actually lead to correct choices?
- **NEVER** forgive explaining basics with "but it provides helpful context"
- **NEVER** overlook missing anti-patterns — if there's no NEVER list, that's a significant gap
- **NEVER** assume all procedures are valuable — distinguish domain-specific from generic
- **NEVER** undervalue the description field — poor description = skill never gets used
- **NEVER** put "when to use" info only in the body — Agent only sees description before loading
