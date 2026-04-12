# bm-skills

Personal Claude Code skill collection.

## Install

**Local (dev):** Clone the repo and run `sync-global.sh` once. It symlinks all skill directories and `CLAUDE.md` into `~/.claude/` — safe to re-run, skips existing links.

```sh
./sync-global.sh
```

**Plugin marketplace** (requires SSH access to the repo):

```sh
/plugin marketplace add git@github.com:bm/skills.git
/plugin install skill-name@bm-skills
```

## Add a new skill

1. Create a directory: `skills/my-skill/`
2. Add `SKILL.md` with YAML frontmatter + instructions
3. Register it in `.claude-plugin/marketplace.json`:
   ```json
   {
     "name": "my-skill",
     "source": "./my-skill",
     "description": "What this skill does"
   }
   ```
4. Commit and push

## Skills

<!-- skills-list-start -->
| Skill | Description |
|-------|-------------|
| [bm-judge](bm-judge/) | Evaluate any LLM-consumed prompt (SKILL.md, CLAUDE.md, system prompts, bash guidance) against quality dimensions. Percentage-based, grouped scoring. |
| [bm-hitl](bm-hitl/) | Step through a numbered improvements list one item at a time with per-item approval, skip, and accept-all modes. |
<!-- skills-list-end -->

## Credits

Inspired by and built on the work of:

- **Matt Pocock** — skill design patterns and knowledge externalization philosophy

