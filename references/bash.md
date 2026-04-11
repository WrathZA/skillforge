# Bash Rules

## NEVER

- **NEVER chain Bash commands with `&&` or `;`** — Claude Code's safety check fires on ambiguous multi-command calls and interrupts mid-flow. Run each command as a separate Bash tool call. This applies to `git` and `gh` especially: `git` triggers "ambiguous syntax" prompts on chained add+commit; `gh` fails silently mid-chain.

- **NEVER use `|` (pipe) in Bash commands** — Claude Code stops execution when it encounters a pipe, interrupting the agent without warning. Run each command separately; if you need the output, redirect with `>` to a temp file and read it back with the Read tool. Note: `|` in markdown table row syntax is unaffected.

- **NEVER use `$()` command substitution in Bash blocks** — Claude Code's permission system prompts on `$()` during execution, interrupting unnecessarily. Use separate Bash calls and write outputs to files instead.

- **NEVER use bash heredoc (`cat > file << 'EOF'`)** to write file content — heredocs containing `#`-prefixed lines trigger Claude Code's security check on every execution. Use the Write tool instead.

- **NEVER pass multi-line content with `#`-prefixed lines as an inline `gh` argument** — headers trigger an un-suppressible permission check prompt. This applies to quoted strings, `$()`, and backtick substitution alike. Write the body to a temp file and pass via `--body-file <file>` instead.

- **NEVER use an external runtime (python3, jq, curl) when a Claude Code built-in tool can do the same** — built-in tools (Write, Read, Edit, Bash, Grep, Glob) are always available; external dependencies are not. Use external tools only when no built-in equivalent exists (e.g. `python3` for hostname/timestamp acquisition where shell equivalents trigger permission prompts on some platforms).

- **NEVER use quoted strings as separator output between commands** (e.g. `echo "---"`) — use blank lines or text output instead.

- **NEVER design prompts that rely on empty-line Enter for any action** — Claude Code CLI cannot submit an empty line; every selectable option including defaults must have an explicit key (e.g. `(n)one`, `(s)kip`, `(c)ontinue`).
