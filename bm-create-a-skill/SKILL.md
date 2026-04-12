---
name: bm-create-a-skill
description: Create a new Claude Code skill with bm-standard structure, knowledge delta discipline, pattern selection, and bm-judge self-evaluation before install. Prefer this over write-a-skill when bm-standard quality is required. Use when the user wants to build, write, scaffold, or create a new skill or SKILL.md. Trigger phrases: "create a skill", "write a skill", "new skill", "build a skill", "scaffold a skill", "bm-create-a-skill".
---

# BM Create-a-Skill

Write skills that score ≥B on bm-judge out of the box. Every section must earn its tokens.

---

## Phase 1 — Discovery

Ask these questions before writing a single line. One message, all at once:

1. **Domain**: What task or domain does this skill cover?
2. **Decisions**: What non-obvious decisions does the agent need to make? (These are your knowledge delta candidates.)
3. **Failure modes**: What goes wrong without this skill? What will the NEVER list cover?
4. **Audience**: Is the output fragile (one wrong byte breaks it) or creative (multiple valid outputs)? This sets freedom level.
5. **Size**: Will this need reference files, or is it self-contained?

Do not proceed until you have answers to 1–3. 4 and 5 can be inferred if not provided.

---

## Phase 2 — Pattern Selection

**MANDATORY — READ [`references/pattern-selection.md`](references/pattern-selection.md)** before selecting a pattern.

Select one pattern. State your choice and the one-line reason before drafting.

---

## Phase 3 — Draft

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
3. Remind the user to run `sync-global.sh` to activate (or run it directly if permitted):
   ```
   ./sync-global.sh
   ```

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

- **NEVER write the description last**
  **Instead:** Draft the description first (or second, after pattern selection) — it forces clarity on WHAT and WHEN before you commit words to the body.
  **Why:** Description written last tends to describe what was written, not what the skill should do. The description is the skill's trigger — poor trigger = skill never activates.
