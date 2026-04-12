---
name: bm-create-a-skill
description: Create a new SKILL.md: pattern selection, knowledge delta discipline, bm-judge self-evaluation before install. Prefer over write-a-skill when bm-standard quality is required. Triggers: create/write/build/scaffold a skill, new skill, SKILL.md.
---

# BM Create-a-Skill

Write skills that score ≥B on bm-judge out of the box. Every section must earn its tokens.

---

## Phase 1 — Discovery

Build understanding through a running recap. Ask questions to fill gaps; after each exchange, show the current recap:

```
## Discovery Recap

**Domain:** [what the skill covers, or "unknown"]
**Decisions:** [non-obvious choices the agent must make, or "unknown"]
**Failure modes:** [what breaks without this skill, or "unknown"]
**Audience:** [fragile/creative output, or "inferred: ..."]
**Size:** [reference files needed, or "inferred: self-contained"]
```

Then ask: `(a)ccept / (r)evise / (q)uit`

- `a` — recap is complete; proceed to Phase 2
- `r` — user adds or corrects; update recap and loop
- `q` — abort

Do not proceed to Phase 2 until the user accepts the recap. Domain, decisions, and failure modes must be filled before accepting — do not accept a recap with "unknown" in those three fields.

---

## Phase 2 — Pattern Selection

**MANDATORY — READ [`references/pattern-selection.md`](references/pattern-selection.md)** before selecting a pattern.

Select one pattern. State your choice and the one-line reason before drafting.

---

## Phase 3 — Draft

**MANDATORY — WebFetch `https://agentskills.io/specification`** before writing the description. Use the live spec to verify current frontmatter requirements and description field constraints.

Write the description before the body. Draft the body around what the description promises.

Write to earn tokens. For every paragraph, ask: **"Does Claude already know this?"**

- If yes → delete it
- If "it's a useful reminder" → one line max, then move on
- If no → expand it; this is the value

**Description requirements** (THE most critical field):
- Answers WHAT (what does it do?)
- Answers WHEN (trigger scenarios — "Use when...", "Trigger phrases:")
- Contains searchable KEYWORDS (domain terms, file extensions, action verbs)
- Max ~200 chars for the core sentence; trigger phrases can follow

**NEVER rules format** — every NEVER must have:
```
- **NEVER [specific construct/pattern]**
  **Instead:** [concrete alternative]
  **Why:** [non-obvious failure mode this avoids]
```

Vague warnings ("be careful", "avoid errors") are prohibited.

**Progressive disclosure thresholds**:
- Body > 300 lines → move heavy content to `references/`
- Any section with a decision tree of 4+ branches → extract to `references/` regardless of total line count
- Add MANDATORY READ triggers at the exact workflow step that needs it
- Add "Do NOT load" guidance for files irrelevant to the current scenario

---

## Phase 4 — Self-Evaluate

Invoke `/bm-judge` on the draft.

Target: ≥B (80%+). For a SKILL.md with no bash guidance → U + S (120 pts max) → ≥96 pts.

If any dimension scores below 80%, invoke `/bm-hitl` on the numbered improvements list bm-judge produced. Do not apply fixes manually — that's /bm-hitl's job.

If the /bm-hitl loop stalls on a dimension (same item rejected after 3 revisions), surface it to the user: "Stuck on [dimension] — here's what I tried. Options: accept the current draft, revise the scope, or skip."

If the draft scores ≥B, proceed. Do not chase A — self-scoring A is a warning sign the criteria were written to fit the skill.

---

## Phase 5 — Review & Install

Present the final draft to the user. Ask:

```
(a)pprove and install, (r)evise, (s)kip install?
```

Wait for explicit approval before installing. On `a`:

1. Create the directory: `/home/bm/code/skills/<name>/`
2. Write `SKILL.md` and any `references/` files

Do not add README.md, CHANGELOG.md, or any documentation about the skill itself — only what the agent needs to perform the task.

---

## NEVER

- **NEVER write a section that restates Claude defaults** ("write clean code", "handle errors", "be helpful")
  **Instead:** Ask: "Would Claude do this without being told?" If yes, delete it.
  **Why:** Default restatements dilute expert signal and train authors that padding is acceptable.

- **NEVER add a NEVER rule without WHY and INSTEAD**
  **Instead:** Complete the three-part format before moving on.
  **Why:** A prohibition without an alternative gets violated when the obvious path is blocked.

- **NEVER dump all content in SKILL.md**
  **Instead:** Keep body under 300 lines; move detail to `references/` with MANDATORY READ triggers.
  **Why:** A 700-line SKILL.md loads all at once on every invocation — the agent drowns in irrelevant content.

- **NEVER skip Phase 4** (bm-judge self-eval)
  **Instead:** Run it even if the draft feels good.
  **Why:** Skills that skip self-eval consistently have U1 or U3 gaps that aren't obvious to the author.

- **NEVER manually apply bm-judge findings one-by-one**
  **Instead:** Invoke `/bm-hitl` on the numbered improvements list bm-judge produced.
  **Why:** Manual application skips the approval loop, bundles changes without diffs, and defeats the purpose of the numbered improvements format.

