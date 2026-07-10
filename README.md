# subagent

A tiny wrapper around the [pi coding agent](https://github.com/badlogic/pi-mono) for spawning subagents from workflows and other agents. It bakes in the always-args (`pi -p --no-session --model …`), resolves bare model names, and adds a few quality-of-life flags.

```
subagent <model> [pi-args...] "prompt"
```

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/kacperkwapisz/subagent/main/install.sh | bash
```

Installs a single bash script to `~/.local/bin/subagent` (override with `SUBAGENT_INSTALL_DIR`). Requires `pi` on your PATH:

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

Rankings, higher = better. Cost reflects what I actually pay (OpenAI has really generous limits), not list price. Intelligence is how hard a problem you can hand the model unsupervised. Taste covers UI/UX, code quality, API design, and copy.

| model       | cost | intelligence | taste |
|-------------|------|--------------|-------|
| gpt-5.5     | 9    | 8            | 5     |
| sonnet-5    | 5    | 5            | 7     |
| opus-4.8    | 4    | 7            | 8     |
| fable-5     | 2    | 9            | 9     |

How to apply:

- These are defaults, not limits. If a cheaper model's output doesn't meet the bar, rerun with a smarter model. Judge the output, not the price tag — escalating costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships, intelligence > taste > cost.
- **Bulk/mechanical work** (clear-spec implementation, data analysis, migrations): `gpt-5.5` — it's effectively free.
- **Anything user-facing** (UI, copy, API design) needs taste ≥ 7.
- **Reviews** of plans/implementations: `fable-5` or `opus-4.8`, optionally `gpt-5.5` as an extra independent perspective.
- Never use Haiku.
- For work that doesn't require changes (investigation, review, data analysis), add `-r` for read-only tools.
- For long prompts/specs, write them to a file and pass with `@spec.md` instead of inlining. For hard unsupervised problems, add `--thinking high` (or `xhigh`).
- Long-running agents: use `--bg <name>` and poll with `tail` instead of blocking. Run parallel independent subagents (e.g. multiple reviewers) concurrently, each with its own `--bg` name. For runs long enough that a crash would hurt, use raw `pi -p -n "<name>" …` (keeps the session) so it's resumable with `pi -r`.
- When parsing output programmatically, add `--mode json` (newline-delimited events); plain `-p` output contains terminal escape codes.

These rankings come from hands-on use; [evals](evals/) to back them (and cover new models) are in progress.

## Teaching your agents to use it

Copy [`docs/AGENTS.md`](docs/AGENTS.md) (or the relevant section) into your global agent instructions (`~/.pi/agent/AGENTS.md`, `CLAUDE.md`, etc.) so your top-level agent knows when and how to delegate.

## License

MIT
