# Bash Rules

## NEVER / INSTEAD

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

- **NEVER use quoted strings as separator output between commands** (e.g. `echo "---"`)
  **Instead:** Use blank lines or plain text output outside of tool calls.

- **NEVER design prompts that rely on empty-line Enter for any action**
  **Instead:** Every selectable option including defaults must have an explicit key (e.g. `(n)one`, `(s)kip`, `(c)ontinue`).
  **Why:** Claude Code CLI cannot submit an empty line.

---

## Common Patterns

### git commit with multi-line message
```
Write → /tmp/commit-msg.txt
git commit -F /tmp/commit-msg.txt
```

### Capture command output for later use
```
Run command with Bash, output redirected: somecommand > /tmp/out.txt
Read /tmp/out.txt
```

### gh PR / issue with body
```
Write body → /tmp/body.txt
gh pr create --title "..." --body-file /tmp/body.txt
```
