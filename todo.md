# Todo

> Flat list for now. Will migrate to GitHub Issues.

---

## bm-judge

- [ ] Re-run self-evaluation after HITL session — expect ≥B now
- [ ] Evaluate user's global `CLAUDE.md` + `bash.md` with bm-judge (first real C+B group evaluation)
- [ ] Decide fate of `skill-judge` — redundant now that bm-judge covers skills; deprecate or keep as thinner wrapper?
- [ ] Flesh out C group rubric with real examples once we have CLAUDE.md evaluations to learn from
- [ ] Define what a new type module needs before adding it (entry criteria for adding Group X)

## bm-hitl

- [ ] Handle no-git-repo case gracefully — currently silently skips commits with no warning to user

## New Skills

- [ ] `create-a-skill` — skill for scaffolding new skills (frontmatter, structure, pattern selection)
- [ ] `update-a-skill` — skill for improving existing skills (diff-aware, preserves intent)

## General

- [ ] `sync-global.sh` — document what it does in README or a comment
- [ ] Add skills list to README (the `<!-- skills-list -->` markers are there but empty)
- [ ] Add credits section to README — shout out people these skills are based on, including Matt Pocock
