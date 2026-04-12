---
name: bm-update-a-skill
description: Update an existing SKILL.md: recap, detect description drift, HITL change elicitation, apply, validate with bm-judge + bm-hitl. Use when modifying, improving, or extending a skill. Triggers: update/modify/revise/change this skill, edit SKILL.md.
---

# BM Update-a-Skill

Understand before touching. Confirm before applying. Judge what you've done.

---

## Phase 0 — Load & Recap

**MANDATORY** — Before reading the skill, fetch current platform docs in parallel:
- **WebFetch `https://agentskills.io/specification`** — live frontmatter requirements and field constraints
- **WebFetch `https://code.claude.com/docs/en/skills`** — Claude Code-specific features (new frontmatter fields, description char limits, invocation controls)

Note any constraints or features relevant to the skill being updated. These inform both the recap and the consistency checks in Phase 1.

Identify the target skill. The user may name it, paste a path, or point to it in context.

If no skill is identified, ask once: "Which skill do you want to update? (name or path)"

If the named skill file does not exist, stop: "Can't find [name] — check the path and re-invoke."

Read the skill completely. Produce a structured recap:

```
## [Skill Name] — Recap

**Does:** [1–2 sentences: core task and when it fires]
**Pattern:** [Tool / Process / Navigation / Mindset / Philosophy]
**Workflow:** [numbered phases or key steps, one line each]
**NEVER rules:** [count] covering [topics]
**References:** [list references/ files, or "none"]
```

**Drift check**: compare the frontmatter `description` field against the actual implementation. If they diverge (description omits key phases, misnames the trigger, or claims behaviour the skill doesn't exhibit), surface the discrepancy:

```
Drift detected: [what the description says] vs [what the skill actually does]
(s)uggest fixes / (i)gnore and continue
```

On `(s)`: produce a corrected description and add it to the Phase 1 change list as item 0 (applied first). On `(i)`: proceed without changing the description.

State the recap to the user. Confirm:

```
Does this match your understanding? (y)es / (n)o
```

On `(n)`: collect the correction, update the recap, confirm again before proceeding. After two corrections without agreement, ask directly: "What specifically is inaccurate?" rather than guessing again.

---

## Phase 1 — Change Elicitation Loop

**Goal**: A numbered change list that is specific, unambiguous, and consistent with the existing skill and principles. Do not touch the file until the list is confirmed.

### Loop

Elicit changes, paraphrase back with the change summary and consistency check below, then ask:

```
(y)es, confirmed — lock list and proceed / (n)o, revise
```

On `(y)`: lock the numbered list and proceed to Phase 2.

If the user adds items after confirming `y`:

```
New items added after confirmation — (r)estart Phase 1 with full revised list / (p)roceed with confirmed list
```

After each response, produce:

```
## Proposed changes

1. [Change — specific enough to apply unambiguously]
2. ...

## Consistency check

[ ] Rule conflict: [conflicting rule text, or "none"]
[ ] Duplicate guidance: [overlapping section, or "none"]
[ ] Principles violation: [issue, or "none"]
[ ] Scope unclear: [vague term that needs scoping, or "none"]
```

### What triggers each consistency flag

**Rule conflict**: New NEVER contradicts an existing NEVER; new step breaks existing flow order.

**Duplicate guidance**: New section covers the same ground as an existing one — flag and ask: "merge or replace?"

**Principles violation**: NEVER missing WHY or INSTEAD. Request for generic advice ("write clean code", "be thorough"). Any rule that restates what Claude does by default.

**Scope unclear**: "Make it shorter" without specifying what to cut; "improve it" without specifying how. Resolve to specific sections or criteria before adding to the list.

Loop does not advance on ambiguity. Every item in the confirmed list must be independently actionable.

---

## Phase 2 — Apply Changes

Apply all confirmed changes from the Phase 1 list to the skill file. Show a concise diff summary after applying:

```
## Changes applied

- [file]:[lines] — [one-line description]
```

If any change affects the skill's structure or pattern type, select the correct pattern before applying:

| Pattern | ~Lines | Use when |
|---------|--------|----------|
| Mindset | ~50 | Creative tasks requiring taste/judgment; high freedom |
| Navigation | ~30 | Multiple distinct scenarios routed to sub-files |
| Philosophy | ~150 | Art/creation requiring originality; internalize-then-express |
| Process | ~200 | Complex multi-step projects with phased checkpoints |
| Tool | ~300 | Precise operations on specific formats; low freedom |

If any change affects frontmatter fields, verify compliance against the spec and Claude Code docs fetched in Phase 0 before applying.

---

## Phase 3 — Judge & HITL

Invoke `/bm-judge` on the modified skill.

- Score ≥B (80%+): proceed to Phase 4.
- Score <B: invoke `/bm-hitl` on the numbered improvements bm-judge produced. After bm-hitl completes, proceed to Phase 4.

If bm-hitl stalls on an item (same rejection after 3 revisions), surface to the user:

```
Stuck on [item] — (a)ccept current state / (r)evise scope / (s)kip
```

Do not loop indefinitely.

---

## Phase 4 — Approve & Save

Show changed sections only (not the full file). Ask:

```
(a)pprove and save / (r)evise / (s)kip save
```

On `(r)`: return to Phase 1 with the user's revision request.

On `(a)`: write the file. If the skill is under `/home/bm/code/skills/`, run `bash /home/bm/code/skills/sync-global.sh` to activate. If under `/home/bm/.claude/skills/`, changes are immediately active.

---

## NEVER

- **NEVER apply changes before Phase 1 produces a confirmed change list**
  **Instead:** Run the elicitation loop until the user explicitly responds `y`.
  **Why:** Applying ambiguous changes produces a result the user didn't want; the subsequent bm-judge then evaluates the wrong output.

- **NEVER skip the four-point consistency check on each proposed change**
  **Instead:** Run all four checks every iteration, even for simple-sounding requests.
  **Why:** "Add a NEVER rule" sounds trivial but frequently introduces rule conflicts or violates the three-part format — these only surface under cross-reference.

- **NEVER apply Phase 1 changes one-by-one through bm-hitl**
  **Instead:** Apply all confirmed Phase 1 changes together in Phase 2; reserve bm-hitl for Phase 3 judge findings.
  **Why:** bm-hitl is designed for judge-produced findings. Using it for user-confirmed changes conflates two semantically different approval loops and confuses which loop the user is in.

- **NEVER skip Phase 3 (bm-judge) after applying changes**
  **Instead:** Always judge the modified skill before presenting for final approval.
  **Why:** A change that looks correct can silently drop the skill below grade; catching this before install is far cheaper than fixing it post-install.

- **NEVER show the full modified file as the review artifact in Phase 4**
  **Instead:** Show only changed sections with file:line ranges.
  **Why:** Full-file reviews bury actual changes; reviewers lose focus and approve without reading what changed.
