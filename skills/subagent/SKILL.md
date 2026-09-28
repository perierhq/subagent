---
name: subagent
description: Delegate work to subagents via the `subagent` CLI (a pi wrapper). Use when spawning subagents, running parallel agents, delegating bulk/mechanical work, getting independent reviews, or picking which model to use for a task. Triggers on - delegate, subagent, spawn agent, parallel agents, background agent, which model, model selection, second opinion, independent review.
---

# subagent — delegation and model selection

Run subagents with the `subagent` wrapper (on PATH; expands to `pi -p --no-session --model …` and resolves bare model names — gpt-* → openai-codex, sonnet/opus/fable → anthropic, grok-* → xai-oauth):

```sh
subagent gpt-6-sol "Task: implement the spec"
```

## Picking the right model

Rankings, higher = better (1–9). Cost is scored from list prices (input-weighted — agentic work is input-heavy); if the user's subscription makes a model effectively free, treat its cost as 9. Intelligence is how hard a problem you can hand the model unsupervised. Taste covers UI/UX, code quality, API design, and copy. Evaluated 2026-07-10 (AA + CursorBench benchmarks, shill-filtered sentiment, internal trials); deprecated models replaced by their successors (plus grok-4.7, successor of the evaluated grok-4.5) 2026-09-27 on AA + CursorBench 4.0 data, with taste carried over from each predecessor until the post-ship trials and sentiment audit.

| model         | cost | intelligence | taste | notes |
|---------------|------|--------------|-------|-------|
| opus-5.5      | 5    | 9            | 8     | top of AA intelligence, Terminal-Bench 4.0 and CursorBench 4.0; honest, pushes back; `--thinking high` is the value point, max effort is very verbose |
| fable-5.1     | 3    | 9            | 9     | best taste; now trails opus-5.5 on agentic benchmarks at 2.5× the price; quota-heavy — orchestrator, not executor |
| gpt-6-sol     | 7    | 8            | 6     | half gpt-5.6-sol's price; run at the highest thinking level available: the score holds at `--thinking xhigh` (AA intel 44, Terminal-Bench 4.0 30 — on par with gpt-5.6-sol at xhigh), and AA's max level scores higher (48 / 44); below xhigh agentic scores drop steeply; API design strong, UI thin; verify diffs |
| sonnet-5      | 6    | 5            | 7     | new tokenizer makes real cost ~1.4× sticker |
| gpt-5.6-terra | 7    | 7            | 7     | bulk-work default: fast, surprisingly strong UI |
| grok-4.7      | 7    | 7            | 6     | fast, cheap list price ($2/$6) but verbose; best non-Anthropic CursorBench 4.0 score; `--thinking high` is nearly as good as xhigh; never use for reviews (predecessor was badly calibrated as a reviewer) |
| gpt-6-luna    | 9    | 5            | 6     | cheap+fast tier for high-volume mechanical work |

How to apply:

- These are defaults, not limits. You have standing permission to override them: if a cheaper model's output doesn't meet the bar, rerun or redo the work with a smarter model without asking. Judge the output, not the price tag. Escalating costs less than shipping mediocre work.
- Cost is a tie-breaker only; when axes conflict for anything that ships, intelligence > taste > cost.
- Bulk/mechanical work (clear-spec implementation, data analysis, migrations): gpt-5.6-terra or gpt-6-sol (same price tier, gpt-6-sol is smarter at its top thinking level); gpt-6-luna for trivial high-volume tasks.
- Anything user-facing (UI, copy, API design) needs taste >= 7: fable-5.1 or opus-5.5 first; gpt-5.6-terra is acceptable for straightforward UI work.
- Reviews of plans/implementations: opus-5.5 or fable-5.1, optionally a gpt-* as an extra independent perspective (use a different provider than the implementer). Not grok-4.7.
- gpt-6-sol: independent evaluators flagged eval-gaming behavior in its predecessor gpt-5.6-sol — until the audit clears it, verify its diffs/tests on unsupervised runs rather than trusting green checkmarks.
- Only models in this table are vetted. Candidates under evaluation live in the repo: evals/CANDIDATES.md.
- Never use Haiku.

## Mechanics

- For work that doesn't require changes (investigation, review, data analysis), add `-r` for read-only tools: `subagent opus-5.5 -r "review the diff on this branch"`.
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
