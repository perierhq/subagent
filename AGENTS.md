# AGENTS.md — working rules for this repo

## Eval rule: how model ratings are made

Never rate a model off a single benchmark number, and never copy a leaderboard rank into our table.

**Disqualified sources — never count these, in any direction:**

- **Anything the model's own provider says about its model.** Launch posts, self-reported benchmarks, system cards, employee/DevRel posts, ambassador and partner testimonials. Biased by construction. Independent third parties only.
- **SWE-Bench Pro and every SWE-Bench-family benchmark.** Disqualified outright. If a source's claim rests on SWE-Bench numbers, the claim is out too. (AA's indices are fine — independently run, no SWE-Bench components.)

A rating (re)evaluation has three mandatory inputs:

1. **Full AA coding data — not just intelligence.** Pull every coding-relevant benchmark Artificial Analysis publishes via `evals/aa-fetch.sh`: Coding Index, Terminal-Bench 2.1 + Hard (agentic coding), tau²-bench (agentic tool use), LiveCodeBench, SciCode, IFBench (instruction following), LCR (long context). The Intelligence Index is context, not the answer. Weight agentic benchmarks (Terminal-Bench, tau²) highest — subagents run unsupervised in terminals; that's the job.

2. **Public sentiment from X, shill-filtered.** Research what practitioners actually say on x.com using the aside CLI (load the `aside-browser` skill). Aggressively exclude paid promotion: sponsored/affiliated accounts, model-lab ambassadors and partners, launch-day hype threads, engagement farmers, and anyone whose praise never comes with receipts — plus everything on the disqualified-sources list above. Weight independent developers showing real work — transcripts, diffs, failure reports, "used it for two weeks" longitudinal takes. Negative reports are worth more than positive ones; nobody gets paid to complain.

3. **Hands-on use.** Taste (UI/UX, code quality, API design, copy) and real cost (what we actually pay on our plans, not list price) can only come from using the model on real work.

Synthesize all three into our own cost / intelligence / taste scores (1–9). When sources disagree, trust hands-on > shill-filtered sentiment > benchmarks.

Then: update the table in `skills/subagent/SKILL.md` (single source of truth), bump `VERSION` in `bin/subagent`, commit — users pick it up via `subagent update`.

## Other repo rules

- `skills/subagent/SKILL.md` is the single source of truth for rankings and delegation guidance; `README.md` and `docs/AGENTS.md` must not duplicate the table.
- `bin/subagent` stays a dependency-free bash script; test changes against a stubbed `pi` before committing.
- Never commit API keys (`AA_API_KEY` etc.).
- Attribute Artificial Analysis wherever their data is shown (their API terms require it).
