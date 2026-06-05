# Adding New Evaluation Groups to skill-forge-judge

Reference for deciding when and how to add a new type-specific group (e.g., Group D, Group E).

---

## Entry Criteria

A new group is justified only when ALL of the following are true:

1. **Gap exists**: You have encountered 3+ prompts of this type where scoring U alone misrepresents quality — i.e., a prompt could score A on U+S but fail at domain-specific concerns a new group would catch.

2. **Unique dimensions**: You can identify at least 3 dimensions that are specific to this type and NOT already captured by U1–U5 in disguise. If a proposed dimension is "better accuracy for U3" or "U1 with a different lens", it belongs in the universal rubric, not a new group.

3. **Stable rubric**: You have at least 2 real evaluated examples to calibrate high/medium/low scores. A rubric written without calibration examples will drift — criteria that sound right in theory often score wrong in practice.

4. **Clear detection**: You can write a single-sentence detection rule for Step 0 (e.g., "Contains bash/shell guidance → B"). If the detection requires judgment calls, the group boundary is not clean enough to ship.

5. **Self-applicable**: The group's dimensions must be evaluatable against the skill-forge-judge SKILL.md itself without contradiction. If adding the group would lower skill-forge-judge's self-eval below B, the criteria are wrong.

---

## Process for Adding a Group

1. Write 2–3 real evaluations using U-only scoring first. Note what U misses.
2. Draft candidate dimensions (minimum 3, max 5). Each must have: name, points, rubric table, what-to-check list.
3. Retroactively score the 2–3 existing evaluations with the new group. Verify the scores feel correct — adjust rubric until they do.
4. Add a reference file: `references/<type>-dimensions.md`
5. Update SKILL.md: add group to the group table, add detection rule to Step 0, add row to report template.
6. Run skill-forge-judge self-evaluation. Expected score must remain ≥B.

---

## Anti-patterns for New Groups

- **The Refinement Group**: A group that just re-scores U dimensions with "more specificity". If it doesn't add unique dimensions, it adds noise not signal.
- **The One-Example Group**: Built to handle one specific prompt you just evaluated. Wait for 3+ examples — patterns only emerge from multiple instances.
- **The Overlap Group**: Dimensions that duplicate existing group content with different names. Run a diff against all existing dimension files before proposing.
- **The Points Inflation Group**: Adding a group primarily to increase total possible points and make bad prompts look proportionally better. Max points should reflect coverage, not ambition.
