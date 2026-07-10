# subagent

A tiny wrapper around the [pi coding agent](https://github.com/badlogic/pi-mono) for spawning subagents from workflows and other agents. It bakes in the always-args (`pi -p --no-session --model …`), resolves bare model names, and adds a few quality-of-life flags.

```
subagent <model> [pi-args...] "prompt"
```

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/kacperkwapisz/subagent/main/install.sh | bash
```

This installs two things:

1. **The CLI** → `~/.local/bin/subagent` (override with `SUBAGENT_INSTALL_DIR`)
2. **The agent skill** → `~/.agents/skills/subagent/` (override with `SUBAGENT_SKILL_DIR`, skip with `SUBAGENT_NO_SKILL=1`) — teaches your agent model selection and delegation mechanics, loaded on demand so it costs no context until used

Then paste the 3-line snippet from [`docs/AGENTS.md`](docs/AGENTS.md) into your global agent instructions (`~/.pi/agent/AGENTS.md`, `~/.claude/CLAUDE.md`, …) so your agent knows subagents exist and reaches for the skill.

Requires `pi` on your PATH:

```sh
npm install -g @earendil-works/pi-coding-agent
```

## Usage

```sh
# bulk/mechanical work
subagent gpt-5.5 "Task: implement the spec"

# read-only investigation / review
subagent fable-5 -r "review the diff on this branch"

# long spec from a file, hard problem, run in background
subagent gpt-5.5 --thinking high @spec.md --bg worker "Task: implement the spec"
tail -f /tmp/agent-worker.log
```

### Flags

| flag | effect |
|---|---|
| `-r`, `--ro` | read-only tools (`read,grep,find,ls`) — for investigation, review, analysis |
| `--bg <name>` | run in background, log to `/tmp/agent-<name>.log`, print `pid=… log=…` |
| `--version` | print version |

Everything else passes through to `pi` (e.g. `--thinking high`, `@file.md` prompts, `--mode json` for machine-readable newline-delimited events).

### Model shorthands

Built-in prefix rules:

- `gpt-*` → `openai-codex/gpt-*`
- `sonnet-*`, `opus-*`, `fable-*`, `haiku-*` → `anthropic/claude-*`
- anything containing `/` is passed through unchanged

Custom shorthands go in `~/.config/subagent/models`, one per line, and take precedence:

```
flash=google/gemini-3-flash
k2=moonshot/kimi-k2
```

## Picking the right model

The model rankings (cost / intelligence / taste) and delegation guidance live in the skill — [`skills/subagent/SKILL.md`](skills/subagent/SKILL.md) — which is the single source of truth. Short version:

- **Bulk/mechanical work** → cheapest model that clears the bar (currently `gpt-5.5`)
- **Anything user-facing** (UI, copy, API design) → high-taste model
- **Reviews** → high-intelligence model, read-only (`-r`), ideally a different provider than the implementer
- Defaults, not limits: judge the output, escalate when it doesn't meet the bar

Rankings come from hands-on use; [evals](evals/) to back them (and score new models) are in progress. When models change, the skill is updated and a re-run of the installer picks it up.

## How the pieces fit

| piece | where it goes | job |
|---|---|---|
| `bin/subagent` | `~/.local/bin` | spawn subagents with the right args |
| `skills/subagent/SKILL.md` | `~/.agents/skills/subagent/` | model selection + mechanics, loaded on demand |
| `docs/AGENTS.md` snippet | your global agent instructions | always-on nudge: "delegate via subagent, load the skill" |

This split keeps your always-on context tiny while the detailed guidance grows with the repo — updating models means editing one skill file and re-running the installer.

## License

MIT
