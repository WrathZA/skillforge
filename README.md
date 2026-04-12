# bm-skills

Personal Claude Code skill collection — hot-swappable domain expertise for Claude Code sessions.

## Install

Clone the repo and run `sync-global.sh` once. It symlinks all skill directories and `CLAUDE.md` into `~/.claude/` — safe to re-run, skips existing links.

```sh
git clone <repo> ~/code/skills
cd ~/code/skills
./sync-global.sh
```

Changes to skill files take effect immediately (symlinked). No re-run needed after edits.

## Skills

### [bm-judge](bm-judge/)

Evaluates any LLM-consumed prompt against quality dimensions. Scores SKILL.md files, CLAUDE.md files, system prompts, and bash/shell guidance using grouped rubrics: Universal (knowledge delta, mindset, anti-patterns, freedom, usability) plus type-specific modules (Skill, CLAUDE.md, Bash). Produces a percentage score, letter grade, and a numbered findings list compatible with bm-hitl.

### [bm-hitl](bm-hitl/)

Steps through a numbered improvement list one item at a time. Shows the full plan as a visual status board upfront, applies each change, then prompts for approval before advancing. Supports approve-all (skip per-item prompts) and stop-all modes. Used automatically by bm-create-a-skill and bm-update-a-skill when bm-judge scores below grade B.

### [bm-create-a-skill](bm-create-a-skill/)

Creates a new SKILL.md through a phased workflow: discovery questions, pattern selection (Mindset / Navigation / Philosophy / Process / Tool), drafting with knowledge-delta discipline, bm-judge self-evaluation, and bm-hitl to fix findings before install. Skills produced by this workflow target ≥B on bm-judge out of the box.

### [bm-update-a-skill](bm-update-a-skill/)

Updates an existing SKILL.md through the same quality gate. Recaps the skill, checks for drift between the frontmatter description and the actual implementation, runs a HITL change-elicitation loop with a 4-point consistency check per proposed change, applies all confirmed changes together, then runs bm-judge + bm-hitl before final save.

### [bm-skill-recap](bm-skill-recap/)

Audits a skill by reading its body independently of its description, then comparing the two. Reports what the skill actually does, what the description claims, any drift (incomplete vs. wrong), and undeclared behaviors added since the description was last updated. Useful before invoking bm-update-a-skill.

## How they fit together

```
Existing?  ──► bm-skill-recap ──► bm-update-a-skill ──┐
                                                       ├──► bm-judge ──► bm-hitl ──► install / save
New skill? ──► bm-create-a-skill ─────────────────────┘
```

`bm-judge` and `bm-hitl` are also useful standalone — judge any prompt, step through any numbered findings list.

## Add a new skill

Use the `bm-create-a-skill` skill from within Claude Code:

```
/bm-create-a-skill
```

Or manually:

1. Create `my-skill/SKILL.md` with YAML frontmatter (`name`, `description`) and a Markdown body
2. Run `./sync-global.sh` to link it into `~/.claude/skills/`

See [agentskills.io/specification](https://agentskills.io/specification) for the full SKILL.md format.

## Principles

Governing rules for how this repo is maintained and how skills are built — see [`principles.md`](principles.md).

Key rules:
- Skills are **knowledge delta**, not tutorials — every line must earn its place
- All interactive prompts use **single keypress `(x)word` format**
- Skills must **never depend on files inside another skill's directory**
- Every NEVER rule needs a **WHY** and an **INSTEAD**

## Credits

- **Matt Pocock** — skill design patterns and knowledge externalization philosophy
- **[softaworks/agent-toolkit](https://github.com/softaworks/agent-toolkit/tree/main/skills/skill-judge)** — `skill-judge`, the original prompt evaluation skill that `bm-judge` is based on
