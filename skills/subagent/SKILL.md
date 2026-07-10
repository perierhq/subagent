---
name: subagent
description: Delegate work to subagents via the `subagent` CLI (a pi wrapper). Use when spawning subagents, running parallel agents, delegating bulk/mechanical work, getting independent reviews, or picking which model to use for a task. Triggers on - delegate, subagent, spawn agent, parallel agents, background agent, which model, model selection, second opinion, independent review.
---

# subagent — delegation and model selection

Run subagents with the `subagent` wrapper (on PATH; expands to `pi -p --no-session --model …` and resolves bare model names — gpt-* → openai-codex, sonnet/opus/fable → anthropic):

```sh
subagent gpt-5.5 "Task: implement the spec"
```

## Picking the right model

Rankings, higher = better (1–9). Cost is scored from list prices (input-weighted — agentic work is input-heavy); if the user's subscription makes a model effectively free, treat its cost as 9. Intelligence is how hard a problem you can hand the model unsupervised. Taste covers UI/UX, code quality, API design, and copy. ⚠️ = provisional (benchmarks + sentiment only, no hands-on verification yet). Evaluated 2026-07-10 per the repo eval rule.

| model         | cost | intelligence | taste | notes |
|---------------|------|--------------|-------|-------|
| gpt-5.5       | 5    | 8            | 5     | hard to steer; strong agentic tool use |
| sonnet-5      | 6    | 5            | 7     | new tokenizer makes real cost ~1.4× sticker |
| opus-4.8      | 5    | 7            | 8     | honest, pushes back; modest step over 4.7 |
| fable-5       | 3    | 9            | 9     | best receipts for hard real work; quota-heavy — orchestrator, not executor |
| gpt-5.6-sol   | 5    | 8 ⚠️         | 5 ⚠️  | agentic > raw coding; METR flagged eval-gaming — verify its diffs |
| gpt-5.6-terra | 7    | 7 ⚠️         | 5 ⚠️  | bulk-work default candidate: ~sol-level coding, half price, fast |
| gpt-5.6-luna  | 9    | 5 ⚠️         | 4 ⚠️  | cheap+fast tier; independent correctness complaints — verify outputs |
| grok-4.5      | 8    | 6 ⚠️         | 3     | decent with guardrails; UI output is its documented weak spot |

How to apply:

- These are defaults, not limits. You have standing permission to override them: if a cheaper model's output doesn't meet the bar, rerun or redo the work with a smarter model without asking. Judge the output, not the price tag. Escalating costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships, intelligence > taste > cost.
- Bulk/mechanical work (clear-spec implementation, data analysis, migrations): gpt-5.6-terra; gpt-5.6-luna for trivial high-volume tasks (verify outputs). gpt-5.5 or gpt-5.6-sol if the user's OpenAI subscription makes them effectively free.
- Anything user-facing (UI, copy, API design) needs taste >= 7: fable-5 or opus-4.8. Never grok-4.5 for UI.
- Reviews of plans/implementations: fable-5 or opus-4.8, optionally a gpt-* as an extra independent perspective (use a different provider than the implementer).
- Treat ⚠️ models with extra verification until hands-on confirms them.
- Never use Haiku.

## Mechanics

- For work that doesn't require changes (investigation, review, data analysis), add `-r` for read-only tools: `subagent fable-5 -r "review the diff on this branch"`.
- For long prompts/specs, write them to a file and pass with `@spec.md` instead of inlining. For hard unsupervised problems, add `--thinking high` (or `xhigh`).
- Long-running agents: use `--bg <name>` to run in background logging to `/tmp/agent-<name>.log`, then poll with `tail` instead of blocking. Run parallel independent subagents (e.g. multiple reviewers) concurrently, each with its own `--bg` name.
- For runs long enough that a crash would hurt, use raw `pi -p -n "<name>" …` (keeps the session) so it's resumable with `pi -r`.
- When parsing subagent output programmatically, add `--mode json` (newline-delimited events); plain `-p` output contains terminal escape codes.
- All other pi flags pass through unchanged. Custom model shorthands live in `~/.config/subagent/models` (`shorthand=provider/model`, one per line).
- Use relevant skills in subagent prompts — tell the subagent which skill to load if one applies.
