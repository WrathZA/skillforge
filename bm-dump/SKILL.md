---
name: bm-dump
description: Zero-friction thought capture from any Claude Code session into the Obsidian vault daily note. Use when the user says "dump this", "capture this", "save this to vault", "note this", or when valuable content surfaces mid-session that should be preserved. Works from any working directory — vault path is hardcoded. Never asks questions at capture time. Trigger phrases: "dump this", "capture this", "note this", "save this to the vault", "add this to my notes".
---

# BM Dump

One job: append what the user gives you to today's daily note. No routing. No tagging. No questions.

## Capture Format

Every entry:

```
### HH:MM — <source>

<content>
```

- **HH:MM**: Run `date +%H:%M` as a separate Bash call to get current time.
- **source**: basename of current working directory. Run `pwd` as a separate Bash call; use only the last path component. If CWD is the vault itself (`RemoteVault`), write `vault`.
- **content**: verbatim dump from the user; light readability cleanup only (typos, punctuation) — no paraphrasing, no structuring.

## Append Command

```
obsidian daily:append content="### HH:MM — source\n\ncontent" vault=RemoteVault
```

Use `\n` for newlines in the content value. Quote values with spaces. If content contains double quotes, escape them as `\"` — or write the content to `/tmp/dump.txt` and append directly to the vault file instead of using the CLI.

**If the CLI errors** (Obsidian not running): append directly to `/home/bm/Documents/RemoteVault/YYYY-MM-DD.md` using the Write or Edit tool. Create the file if it doesn't exist; never overwrite existing content — append only.

**Confirm success with one line**:
```
Captured → YYYY-MM-DD.md [HH:MM — source]
```

## What to Capture

This skill is only activated by explicit invocation — never by detecting phrases mid-conversation.

When invoked:
1. If content was passed directly (e.g. `/bm-dump here's my thought`), capture it.
2. If invoked with no content, ask once: **"What would you like to capture?"** — then capture whatever the user says next verbatim.

Never filter by importance. Trivial, redundant, or half-formed — append it. Value judgment belongs in background processing, not here.

## NEVER

- **NEVER ask where to route the dump**
  **Instead:** Always append to today's daily note, unconditionally.
  **Why:** One routing question at capture time breaks the zero-friction habit. The daily note is the inbox; routing happens in background processing.

- **NEVER create a standalone note at capture time**
  **Instead:** Append to today's daily note. A separate skill (background processing) promotes captures to standalone notes.
  **Why:** Creating a note requires naming, linking, and scoping — all decisions that halt capture flow.

- **NEVER add wikilinks or tags at capture time**
  **Instead:** Capture raw content with timestamp and source only.
  **Why:** Linking is a judgment call. Judgment calls at capture time mean some thoughts don't get captured. Tags and links get added in processing.

- **NEVER paraphrase, summarize, or restructure the content**
  **Instead:** Verbatim capture with minimal readability cleanup.
  **Why:** The raw form is the signal. Rewriting at capture time introduces interpretation drift and changes what future processing sees.

- **NEVER chain the date, pwd, and obsidian calls with `&&` or `;`**
  **Instead:** Run each as a separate Bash tool call.
  **Why:** Claude Code's safety check fires on chained commands and interrupts mid-sequence without warning.

- **NEVER use `$()` substitution when building the obsidian CLI command**
  **Instead:** Run `date +%H:%M` and `pwd` as separate Bash calls, read their output, then construct the command string from those values.
  **Why:** Claude Code's permission system prompts on `$()` during execution, interrupting the capture.
