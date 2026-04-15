# Skill Forge ⚔️

Quality-gated skill authoring for Claude Code. Build, judge, and ship skills that earn their tokens.

![Skill Forge workflow diagram](diagram.svg)

`skill-forge-judge` and `skill-forge-hitl` also work standalone — judge any prompt, step through any numbered list.


## Skills

**[skill-forge-recap](skill-forge-recap/)** — audits a skill by reading its body independently of its description. Reports what the skill *actually* does, flags undeclared behaviors, and verdicts drift as aligned / minor / significant. Use before updating.

**[skill-forge-create](skill-forge-create/)** — builds a new skill from scratch: discovery recap loop to nail domain and failure modes, pattern selection, spec-fetching draft phase enforcing knowledge-delta discipline, then judge + hitl quality gate before install.

**[skill-forge-update](skill-forge-update/)** — structured update workflow for existing skills: recap, drift check, change elicitation loop with consistency checks, applies via hitl, judges the result, then saves and activates.

**[skill-forge-judge](skill-forge-judge/)** — evaluates any LLM-consumed prompt against a dimensional rubric (knowledge delta, anti-patterns, usability, spec compliance). Outputs a letter grade, per-dimension scores, and a numbered improvements list.

**[skill-forge-hitl](skill-forge-hitl/)** — Human-in-the-Loop: steps through any numbered list one item at a time. Shows a status board upfront, applies each change, prompts approve/revise/skip, and commits after each approval.

## Local Setup

Run `symlink-global-skills.sh` once to make skills available across all projects on this machine:

```bash
bash symlink-global-skills.sh
```

Symlinks each skill directory into `~/.claude/skills/`, making them available to any Claude Code session on this machine regardless of working directory. Safe to re-run — already-linked entries are skipped.

## Principles

See [`principles.md`](principles.md). Short version: knowledge delta not tutorials, single-keypress menus, no cross-skill file deps, every NEVER needs WHY + INSTEAD.

## Credits

- **[Matt Pocock](https://github.com/mattpocock)** — `write-a-skill`, the original skill this collection builds on
- **[softaworks/agent-toolkit](https://github.com/softaworks/agent-toolkit/tree/main/skills/skill-judge)** — `skill-judge`, the original eval skill `skill-forge-judge` is based on
