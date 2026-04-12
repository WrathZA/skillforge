---
name: bm-hitl
description: Apply a numbered list one item at a time — status board upfront, per-item approve/skip, approve-all mode, commits after each approved item. Use when stepping through bm-judge findings or any numbered changes. Triggers: apply these, go through each one, apply improvements, commit each change.
---

# HITL Loop

Throw the lasso, pull it tight, move to the next. One change at a time, one approval at a time — no bundling, no skipping ahead.

**Core question for every item:** What's the smallest change that makes this finding false? Apply only that — nothing more.

## Workflow

### 1 — Read the list

Parse the numbered improvement list from context. If there are multiple lists or it's unclear which to apply, ask once before starting — not mid-loop. If the response does not resolve the ambiguity, stop: "Still unclear which list to apply — please re-invoke with the target list quoted directly."

Check git status before showing the board. If the working directory is not a git repo, note this at the top of the board and skip all commit steps:

```
ℹ No git repo — changes will be applied but not committed.
```

Display the full status board upfront so the user can see the whole plan:

```
Applying N improvements:

  [ ] 1. <improvement summary>
  [ ] 2. <improvement summary>
  [ ] 3. <improvement summary>

(A)pprove all — apply every item without per-item prompts
(s)tart — begin item-by-item review
```

If the user responds `A` at the board prompt: apply and commit all items in sequence, then show the final board per step 3.

If the user responds `s` at the board prompt: begin the per-item loop from item #1.

### 2 — Apply each one

Repeat for every item in order:

**a. Announce**
```
─── #N of M ───
<Full improvement description>
```

**b. Apply**

If the smallest change requires touching more than one logical unit (function, section, rule), the improvement is under-scoped — note this in the change summary and apply only the first unit.

Do not touch adjacent code, bundle items, or anticipate the next improvement. If applying this item overlaps with a later item (same lines, same function), apply only what's needed now and note the overlap in the change summary.

**c. Show the change**
```
Changed: <file>:<lines> — <one-line description>
<concise diff summary — not the full file>
```

**d. Ask**
```
(a)pprove, (r)evise, (s)kip, (o)bsolete, (A)ccept-all, (k)skip-all, (Q)uit?
```

Wait. Do not advance until the user responds. Accept single-key input — `a`, `r`, `s`, `o`, `A`, `k`, or `Q`. Any other input is a stop signal: show the current board and ask "Stop here? (y) to pause, (c)ontinue from #N?"

- **a** — commit the change, mark `[✓]`, advance
- **r** — collect guidance, re-apply, show again; repeat until approved. After 3 revisions without approval, surface the stall: "Revised N times — skip and file a separate issue, or keep going?"
- **s** — mark `[–]`, note the reason if given, advance
- **o** — mark `[○]`, note why (already done, no longer applies, impossible), advance without committing
- **A** — commit the current change, then apply and commit all remaining items without per-item prompts; mark each `[✓]` as it completes; show the final board when done
- **k** — mark the current item `[–]`, mark all remaining items `[–]`, show the final board, exit the loop
- **Q** — mark all remaining items `[–]`, show the final board, exit

**e. Update the board**

After each decision, show the current state:
```
  [✓] 1. <done>
  [→] 2. <in progress>
  [ ] 3. <pending>
  [–] 4. <skipped>
  [○] 5. <obsolete>
```

For accept-all (`A`): skip intermediate board updates — apply and commit each remaining item silently, then show the final board once in step 3.

### 3 — Done

When all items are processed, show the final board and a one-liner:

```
Done. Applied: N  Skipped: M  Revised then applied: P
```

## Commits

If in a git repo: commit after each approved change, before advancing to the next item:

```bash
git add <changed files>
```
```bash
git commit -m "<short description of this improvement>"
```

If not in a git repo: skip commits entirely. Mark each approved item `[✓]` and continue — do not warn on every item, the single board-level notice is sufficient.

## NEVER

- NEVER apply two improvements in one change — if both items touch the same code, the user loses the ability to approve them independently, which defeats the purpose of the loop.
- NEVER advance past an item without an explicit approve, revise, or skip response — silence is not approval.
- NEVER ask clarifying questions about an improvement's intent mid-loop — ambiguities must be resolved in step 1 before the first item.
- NEVER show the full file diff — show only the changed lines and a one-line description. Full files bury the signal.
- NEVER let a revision loop run silently past 3 attempts — a stuck item means the improvement is under-specified, not that the agent needs to try harder.
- NEVER offer accept-all (`A`) before the status board has been shown — the status board IS the plan review; once the user has seen all items listed, offering approve-all at the board level or from item #2 onwards is acceptable.
- NEVER treat lowercase `q` as a quit signal — only uppercase `Q` quits; lowercase `q` is keyboard-adjacent to `a` and falls through to the unknown-input stop signal.
