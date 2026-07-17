---
name: subagent
description: Delegate work to subagents via the `subagent` CLI (a pi wrapper). Use when spawning subagents, running parallel agents, delegating bulk/mechanical work, getting independent reviews, or picking which model to use for a task. Triggers on - delegate, subagent, spawn agent, parallel agents, background agent, which model, model selection, second opinion, independent review.
---

# subagent — delegation and model selection

Run subagents with the `subagent` wrapper (on PATH; expands to `pi -p --no-session --model …` and resolves bare model names — gpt-* → openai-codex, sonnet/opus/fable → anthropic, grok-* → xai-oauth):

```sh
subagent gpt-5.5 "Task: implement the spec"
```

## Picking the right model

Rankings, higher = better (1–9). Cost is scored from list prices (input-weighted — agentic work is input-heavy); if the user's subscription makes a model effectively free, treat its cost as 9. Intelligence is how hard a problem you can hand the model unsupervised. Taste covers UI/UX, code quality, API design, and copy. Evaluated 2026-07-10 (AA + CursorBench benchmarks, shill-filtered sentiment, internal trials).

| model         | cost | intelligence | taste | notes |
|---------------|------|--------------|-------|-------|
| gpt-5.5       | 5    | 8            | 5     | hard to steer; strong agentic tool use |
| sonnet-5      | 6    | 5            | 7     | new tokenizer makes real cost ~1.4× sticker |
| opus-4.8      | 5    | 7            | 8     | honest, pushes back; modest step over 4.7 |
| fable-5       | 3    | 9            | 9     | best model for hard real work; quota-heavy — orchestrator, not executor |
| gpt-5.6-sol   | 5    | 8            | 6     | best agentic benchmarks; API design strong, UI thin; verify diffs (METR flagged eval-gaming); sentiment audit 2026-07-22 |
| gpt-5.6-terra | 7    | 7            | 7     | bulk-work default: ~sol-level coding at half price, fast; surprisingly strong UI; sentiment audit 2026-07-22 |
| gpt-5.6-luna  | 9    | 5            | 6     | cheap+fast tier for high-volume mechanical work; sentiment audit 2026-07-22 |

How to apply:

- These are defaults, not limits. You have standing permission to override them: if a cheaper model's output doesn't meet the bar, rerun or redo the work with a smarter model without asking. Judge the output, not the price tag. Escalating costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships, intelligence > taste > cost.
- Bulk/mechanical work (clear-spec implementation, data analysis, migrations): gpt-5.6-terra; gpt-5.6-luna for trivial high-volume tasks; gpt-5.5 or gpt-5.6-sol if the user's subscription makes them effectively free.
- Anything user-facing (UI, copy, API design) needs taste >= 7: fable-5 or opus-4.8 first; gpt-5.6-terra is acceptable for straightforward UI work.
- Reviews of plans/implementations: fable-5 or opus-4.8, optionally a gpt-* as an extra independent perspective (use a different provider than the implementer).
- gpt-5.6-sol: independent evaluators flagged eval-gaming behavior — for unsupervised runs, verify its diffs/tests rather than trusting green checkmarks.
- Only models in this table are vetted. Candidates under evaluation live in the repo: evals/CANDIDATES.md.
- Never use Haiku.

## Mechanics

- For work that doesn't require changes (investigation, review, data analysis), add `-r` for read-only tools: `subagent fable-5 -r "review the diff on this branch"`.
- For long prompts/specs, write them to a file and pass with `@spec.md` instead of inlining. For hard unsupervised problems, add `--thinking high` (or `xhigh`).
- Long-running agents — prefer tmux when installed (`command -v tmux`), especially for long or occasionally-interactive runs (research sessions, slow trials):

  ```sh
  tmux new -d -s "agent-<name>" 'subagent <model> … 2>&1 | tee /tmp/agent-<name>.log'
  tmux capture-pane -pt "agent-<name>" | tail -20   # peek without attaching
  tmux attach -t "agent-<name>"                     # take over interactively if it needs input
  ```

  You get both worlds: a live attachable session and a `tee`'d log to poll. Kill with `tmux kill-session -t <name>` when done.
- Without tmux, fall back to `--bg <name>` (runs in background, logs to `/tmp/agent-<name>.log`), then `subagent logs <name> [-f]` / `subagent wait <name>` / `subagent ps` instead of blocking. Run parallel independent subagents (e.g. multiple reviewers) concurrently, each with its own session/name.
- For runs long enough that a crash would hurt, use raw `pi -p -n "<name>" …` (keeps the session) so it's resumable with `pi -r` — inside tmux if available.
- When parsing subagent output programmatically, add `--mode json` (newline-delimited events); plain `-p` output contains terminal escape codes.
- All other pi flags pass through unchanged. Custom model shorthands live in `~/.config/subagent/models` (`shorthand=provider/model`, one per line).
- Use relevant skills in subagent prompts — tell the subagent which skill to load if one applies.
