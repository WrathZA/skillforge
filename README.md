# bm-skills

Personal Claude Code skill collection — hot-swappable domain expertise for Claude Code sessions.

```
Existing?  ──► bm-skill-recap ──► bm-update-a-skill ──┐
                                                       ├──► bm-judge ──► bm-hitl ──► install / save
New skill? ──► bm-create-a-skill ─────────────────────┘
```

`bm-judge` and `bm-hitl` also work standalone — judge any prompt, step through any numbered list.

## Install

Clone and run `sync-global.sh` once. Symlinks everything into `~/.claude/` — safe to re-run.

```sh
git clone <repo> ~/code/skills
cd ~/code/skills
./sync-global.sh
```

Edits take effect immediately (symlinked).

## Skills

**[bm-judge](bm-judge/)** — scores any LLM-consumed prompt. Handles SKILL.md, CLAUDE.md, system prompts, and bash guidance. Outputs a percentage grade + numbered findings list.

**[bm-hitl](bm-hitl/)** — steps through a numbered list one item at a time. Full plan upfront, approve/skip per item, commits after each approval.

**[bm-create-a-skill](bm-create-a-skill/)** — new skill from scratch: discovery recap loop, pattern selection, draft, bm-judge self-eval, bm-hitl fixes, install.

**[bm-update-a-skill](bm-update-a-skill/)** — same quality gate for existing skills. Recaps, elicits changes with a consistency check, applies, judges, installs.

**[bm-skill-recap](bm-skill-recap/)** — reads a skill body independently of its description and flags drift. Run before updating.

## Add a skill

```
/bm-create-a-skill
```

Or manually: create `my-skill/SKILL.md` with `name` + `description` frontmatter, then `./sync-global.sh`.

Spec: [agentskills.io/specification](https://agentskills.io/specification)

## Principles

See [`principles.md`](principles.md). Short version: knowledge delta not tutorials, single-keypress menus, no cross-skill file deps, every NEVER needs WHY + INSTEAD.

## Credits

- **Matt Pocock** — `write-a-skill`, the original skill this collection builds on
- **[softaworks/agent-toolkit](https://github.com/softaworks/agent-toolkit/tree/main/skills/skill-judge)** — `skill-judge`, the original eval skill `bm-judge` is based on
