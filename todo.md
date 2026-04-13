# Todo

> Flat list for now. Will migrate to GitHub Issues.

---

## bm-judge

- [x] Re-run self-evaluation after HITL session — scored 102/120 (85%, Grade B) ✓
- [x] Evaluate user's global `CLAUDE.md` + `bash.md` with bm-judge — scored 126/150 (84%, Grade B) ✓
  - Gaps fixed in bash.md: added find/grep/cat, interactive flags (-i), --no-verify rules
- [x] Decide fate of `skill-judge` — deprecated; removed symlink from ~/.claude/skills/. Migrated Pattern 6 example to bm-judge failure-patterns.md. Source intact at ~/.agents/skills/skill-judge.
- [x] Flesh out C group rubric with real examples — first eval: global CLAUDE.md + bash.md scored 84% B; rubric held, no gaps found
- [x] Define what a new type module needs before adding it — written in bm-judge/references/extending-groups.md; loading trigger added to SKILL.md

## bm-hitl

- [x] Handle no-git-repo case gracefully — board-level notice + skip commits; no per-item warnings

## New Skills

- [x] `bm-skill-recap` — a skill that reads a skill's actual body and tells you what it *really* does, not what the description claims. Useful for auditing drift between description and implementation.



- [x] `bm-create-a-skill` — Process pattern; Phase 4 routes to /bm-judge → /bm-hitl; scored 84% B → 6 improvements applied via bm-hitl
- [x] `bm-update-a-skill` — Process pattern; recap → HITL elicitation → apply → bm-judge → bm-hitl; scored 82.5% B
- [x] `bm-create-a-skill` + `bm-update-a-skill` Phase 5: run `symlink-global-skills.sh` automatically on install instead of just reminding the user

## General

- [x] `symlink-global-skills.sh` — documented in README Install section
- [x] Add skills list to README — bm-judge and bm-hitl listed
- [x] Add credits section to README — Matt Pocock credited
