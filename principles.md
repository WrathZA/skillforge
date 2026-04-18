# Principles

Rules that govern how this repo is maintained and how skills are built.

---

## Rules live in the repo

Behavioral context — bash rules, conventions, patterns — belongs in tracked files in this repo, not in external memory systems. If something needs to be remembered across sessions, it goes in a `.md` file here and gets referenced from `CLAUDE.md`.

## Every rule needs a WHY and an INSTEAD

A prohibition without a reason gets forgotten or overridden under pressure. A prohibition without an alternative gets violated when the obvious path is blocked. Every rule must answer:
- **WHY** — what breaks if you ignore it
- **INSTEAD** — what to do instead

See the `## Bash` section in `CLAUDE.md` for examples.

## Skills are knowledge delta, not tutorials

A skill's value = expert knowledge − what Claude already knows. Content that restates defaults, explains basic concepts, or describes things Claude does naturally is token waste. Every line should earn its place.

## Evaluation criteria must be self-applicable

Any skill that evaluates other prompts (e.g. `skill-forge-judge`) must be able to evaluate itself and score ≥B. If it can't, the criteria are wrong.

## Skills must never depend on other installed skills

A skill may not reference files inside another skill's directory (e.g. `skill-forge-other/references/foo.md`).

**WHY:** Skills are installed and removed independently. A cross-skill file reference creates a silent runtime breakage whenever the referenced skill is absent, renamed, or updated — with no error surfaced to the user.

**INSTEAD:** Inline the required content directly in the skill body, move it to a `references/` file within the same skill, or use the agentskills.io spec / public URLs for authoritative external content.

## Interactive prompts use single keypress format

All menus and confirmation prompts must use `(x)word` format — one key per option, options separated by ` / `.

**WHY:** Full-word options increase input friction; Claude Code CLI cannot submit empty lines, so any option that relies on implicit defaults silently breaks the flow.

**INSTEAD:** `(a)pprove / (r)evise / (s)kip` — every selectable option has an explicit key, including defaults. Never write `"accept, revise, or skip?"` as plain prose.

## Continuous refinement

A skill is never finished — it can always be sharpened. The forge cycle (recap → update → judge → HITL) is designed to be re-enterable at any point and repeatable without a specific reason to change. Run `/skill-forge-judge` after any recap, even when no drift is detected.

**WHY:** Skills accumulate invisible debt as the codebase, tooling, or usage patterns evolve. A skill that earned its grade months ago may have drifted below it today.

**INSTEAD:** Treat judging as a default close-out step, not a remediation step. The grade tells you whether the skill is still earning its tokens.

## Todo lives in the repo

`todo.md` is the single source of truth for pending work. It will migrate to GitHub Issues when the volume justifies it. Do not track work in memory or conversation context only.
