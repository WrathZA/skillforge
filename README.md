# Skill Forge

Personal Claude Code skill collection — hot-swappable domain expertise for Claude Code sessions.

```
Existing?  ──► skill-forge-recap ──► skill-forge-update ──┐
                                                                   ├──► skill-forge-judge ──► skill-forge-hitl ──► install / save
New skill? ──► skill-forge-create ─────────────────────────┘
```

`skill-forge-judge` and `skill-forge-hitl` also work standalone — judge any prompt, step through any numbered list.


## Skills

**[skill-forge-judge](skill-forge-judge/)** — scores any LLM-consumed prompt. Handles SKILL.md, CLAUDE.md, system prompts, and bash guidance. Outputs a percentage grade + numbered findings list.

**[skill-forge-hitl](skill-forge-hitl/)** — steps through a numbered list one item at a time. Full plan upfront, approve/skip per item, commits after each approval.

**[skill-forge-create](skill-forge-create/)** — new skill from scratch: discovery recap loop, pattern selection, draft, skill-forge-judge self-eval, skill-forge-hitl fixes, install.

**[skill-forge-update](skill-forge-update/)** — same quality gate for existing skills. Recaps, elicits changes with a consistency check, applies, judges, installs.

**[skill-forge-recap](skill-forge-recap/)** — reads a skill body independently of its description and flags drift. Run before updating.

## Principles

See [`principles.md`](principles.md). Short version: knowledge delta not tutorials, single-keypress menus, no cross-skill file deps, every NEVER needs WHY + INSTEAD.

## Credits

- **Matt Pocock** — `write-a-skill`, the original skill this collection builds on
- **[softaworks/agent-toolkit](https://github.com/softaworks/agent-toolkit/tree/main/skills/skill-judge)** — `skill-judge`, the original eval skill `skill-forge-judge` is based on
