<!-- Drop-in snippet for your global agent instructions (~/.pi/agent/AGENTS.md, CLAUDE.md, etc.) -->

## Picking the right models for workflows and subagents

Rankings, higher = better. Cost reflects what I actually pay (OpenAI has really generous limits), not list price. Intelligence is how hard a problem you can hand the model unsupervised. Taste covers UI/UX, code quality, API design, and copy.

| model       | cost | intelligence | taste |
|-------------|------|--------------|-------|
| gpt-5.5     | 9    | 8            | 5     |
| sonnet-5    | 5    | 5            | 7     |
| opus-4.8    | 4    | 7            | 8     |
| fable-5     | 2    | 9            | 9     |

How to apply:
- These are defaults, not limits. You have standing permission to override them: if a cheaper model's output doesn't meet the bar, rerun or redo the work with a smarter model without asking. Judge the output, not the price tag. Escalating costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships, intelligence > taste > cost.
- Bulk/mechanical work (clear-spec implementation, data analysis, migrations): gpt-5.5 - it's effectively free.
- Anything user-facing (UI, copy, API design) needs taste >= 7.
- Reviews of plans/implementations: fable-5 or opus-4.8, optionally gpt-5.5 as an extra independent perspective.
- Never use Haiku.
- Mechanics: run subagents via the `subagent` wrapper (on PATH; expands to `pi -p --no-session --model …` and resolves bare model names — gpt-* → openai-codex, sonnet/opus/fable → anthropic): `subagent gpt-5.5 "prompt here"`. Use relevant skills. All other pi flags pass through.
- For work that doesn't require changes (investigation, review, data analysis), add `-r` for read-only tools: `subagent fable-5 -r "review …"`.
- For long prompts/specs, write them to a file and pass with `@spec.md` instead of inlining. For hard unsupervised problems, add `--thinking high` (or `xhigh`).
- Long-running agents: use `--bg <name>` to run in background logging to `/tmp/agent-<name>.log`, then poll with `tail` instead of blocking. Run parallel independent subagents (e.g. multiple reviewers) concurrently, each with its own `--bg` name. For runs long enough that a crash would hurt, use raw `pi -p -n "<name>" …` (keeps the session) so it's resumable with `pi -r`.
- When parsing subagent output programmatically, add `--mode json` (newline-delimited events); plain `-p` output contains terminal escape codes.
