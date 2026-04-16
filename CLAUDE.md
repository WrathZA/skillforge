# Global Preferences

@principles.md

## Project

This repo contains Claude Code agent skills — each skill is a directory with a `SKILL.md` and optional `references/`. Skills are installed via symlink into `~/.claude/skills/`. See `principles.md` for authoring standards (knowledge delta, WHY+INSTEAD, no cross-skill dependencies).

## Git

- Default branch name is `main` for all repositories.
- Prefer `gh` CLI over `git` CLI for GitHub operations (creating repos, PRs, issues, etc.).

## Bash

- **NEVER chain Bash commands with `&&` or `;`**
  Run each command as a separate Bash tool call.
  **Why:** Claude Code's safety check fires on ambiguous multi-command calls and interrupts mid-flow. Applies to `git` and `gh` especially.

- **NEVER use `|` (pipe) in Bash commands**
  **Instead:** Redirect output with `>` to a temp file, then read it back with the Read tool.
  **Why:** Claude Code stops execution when it encounters a pipe, interrupting the agent without warning.
  Note: `|` in markdown table row syntax is unaffected.

- **NEVER use `$()` command substitution in Bash blocks**
  **Instead:** Run the inner command separately, write its output to a temp file, then use the file.
  **Why:** Claude Code's permission system prompts on `$()` during execution, interrupting unnecessarily.
  Common case — git commit message: use Write tool → `/tmp/msg.txt` → `git commit -F /tmp/msg.txt`

- **NEVER use bash heredoc (`cat > file << 'EOF'`)** to write file content
  **Instead:** Use the Write tool.
  **Why:** Heredocs containing `#`-prefixed lines trigger Claude Code's security check on every execution.

- **NEVER pass multi-line content with `#`-prefixed lines as an inline `gh` argument**
  **Instead:** Write the body to a temp file and pass via `--body-file <file>`.
  **Why:** Headers trigger an un-suppressible permission check prompt. Applies to quoted strings, `$()`, and backtick substitution alike.

- **NEVER use an external runtime (python3, jq, curl) when a Claude Code built-in tool can do the same**
  **Instead:** Use Write, Read, Edit, Bash, Grep, or Glob.
  **Why:** Built-in tools are always available; external dependencies are not.

- **NEVER use `find`, `grep`, `cat`, `head`, `tail` in Bash when a dedicated tool exists**
  **Instead:** Use Glob (file search), Grep (content search), Read (file contents).
  **Why:** Dedicated tools provide better UX, correct permissions, and are reviewable by the user.

- **NEVER use interactive git/gh flags (`-i`, `--interactive`)** (e.g. `git rebase -i`, `git add -i`)
  **Instead:** Use non-interactive equivalents or break the operation into discrete steps.
  **Why:** Claude Code runs in a non-interactive shell; `-i` flags hang waiting for input that never arrives.

- **NEVER use `--no-verify` on git commands** unless the user explicitly requests it
  **Instead:** Fix the underlying hook failure — read the error, diagnose the cause, then commit cleanly.
  **Why:** Bypassing hooks hides real problems (lint failures, test failures, secret detection) and violates trust with the repo's safety net.

- **NEVER use quoted strings as separator output between commands** (e.g. `echo "---"`)
  **Instead:** Use blank lines or plain text output outside of tool calls.

- **NEVER design prompts that rely on empty-line Enter for any action**
  **Instead:** Every selectable option including defaults must have an explicit key (e.g. `(n)one`, `(s)kip`, `(c)ontinue`).
  **Why:** Claude Code CLI cannot submit an empty line.

- **NEVER read skill files via `~/.claude/skills/` paths**
  **Instead:** Use the absolute path to the skills project directory (the directory containing this CLAUDE.md) — e.g. `Read /absolute/path/to/skills/skill-forge-judge/SKILL.md`.
  **Why:** `~/.claude/skills/` is a symlink back to the project directory; Claude Code's permission system fires on symlink traversal and prompts the user, interrupting the agent mid-task.

Outside these rules, use your judgment. Prefer the simplest approach that works — if a rule doesn't cover the situation, act on the merits rather than inventing constraints.

---

### Common Patterns

#### git commit with multi-line message
```
Write → /tmp/commit-msg.txt
git commit -F /tmp/commit-msg.txt
```

#### Capture command output for later use
```
Run command with Bash, output redirected: somecommand > /tmp/out.txt
Read /tmp/out.txt
```

#### gh PR / issue with body
```
Write body → /tmp/body.txt
gh pr create --title "..." --body-file /tmp/body.txt
```
