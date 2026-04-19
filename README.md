# Skill Forge ⚔️

Quality-gated skill authoring for Claude Code. Build, judge, and ship skills that earn their tokens.

Skill Forge is four skills that run in sequence (recap, create or update, judge, apply changes with human-in-the-loop), each pass tightening the prompt until it earns a passing grade. Enter the cycle at any point and repeat until the result is sharp.

![Skill Forge workflow diagram](diagram.svg)

`skill-forge-judge` and `skill-forge-hitl` also work standalone: judge any prompt, step through any numbered list.


## Skills

**[skill-forge-recap](skill-forge-recap/):** reads a skill's body independently of its description. Reports what the skill *actually* does, flags undeclared behaviors, and verdicts drift as aligned / minor / significant. Offers context-sensitive next steps: fix frontmatter via HITL, hand off to skill-forge-update, or run skill-forge-judge.

**[skill-forge-create](skill-forge-create/):** builds a new skill from scratch: discovery recap to identify domain and failure modes, pattern selection, spec-fetching draft phase with knowledge-delta discipline enforced, then judge + HITL quality gate before install.

**[skill-forge-update](skill-forge-update/):** structured update workflow for existing skills: recap, drift check, change elicitation with consistency checks, applies via HITL, judges the result, then saves and activates.

**[skill-forge-judge](skill-forge-judge/):** evaluates any LLM-consumed prompt against a dimensional rubric (knowledge delta, anti-patterns, usability, spec compliance). Outputs a letter grade, per-dimension scores, and a numbered improvements list.

**[skill-forge-hitl](skill-forge-hitl/):** Human-in-the-Loop: steps through any numbered list one item at a time. Shows a status board upfront, applies each change, prompts approve/revise/skip, and commits after each approval.

## Install

These five skills work in concert. `create` and `update` call `judge` and `hitl` as part of the quality gate; `recap` feeds into `update`. Install all five to make the full forge cycle available:

```
/plugin marketplace add WrathZA/skillforge
/plugin install skill-forge-recap
/plugin install skill-forge-create
/plugin install skill-forge-update
/plugin install skill-forge-judge
/plugin install skill-forge-hitl
```

## Principles

See [`principles.md`](principles.md). Short version: knowledge delta not tutorials, single-keypress menus, no cross-skill file deps, every NEVER needs WHY + INSTEAD, and skills are never finished. Judge repeatedly, not just when something breaks.

## Local Development

Clone the repo and run `symlink-global-skills.sh` once to link skills globally on this machine:

```bash
bash symlink-global-skills.sh
```

Symlinks each skill directory into `~/.claude/skills/`, making them available to any Claude Code session regardless of working directory. Edits to the repo are immediately reflected. Safe to re-run: already-linked entries are skipped.

## Credits

- **[Matt Pocock](https://github.com/mattpocock)** ([aihero.dev](https://www.aihero.dev/)): `write-a-skill`, the original skill this collection builds on
- **[softaworks/agent-toolkit](https://github.com/softaworks/agent-toolkit/tree/main/skills/skill-judge)**: `skill-judge`, the original eval skill `skill-forge-judge` is based on
