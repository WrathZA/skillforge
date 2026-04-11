# bm-skills

Personal Claude Code skill collection.

## Install

Add this marketplace once (requires SSH access to the repo):

```sh
/plugin marketplace add git@github.com:bm/skills.git
```

Then install any skill:

```sh
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
<!-- skills-list-end -->
