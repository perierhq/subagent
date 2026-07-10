# evals

The model rankings in [`skills/subagent/SKILL.md`](../skills/subagent/SKILL.md) are not run in-house. They synthesize three inputs, per the eval rule in [`AGENTS.md`](../AGENTS.md):

1. **[Artificial Analysis](https://artificialanalysis.ai) coding benchmarks** — all of them, not just the Intelligence Index
2. **Shill-filtered public sentiment from X** — what independent practitioners actually report
3. **Hands-on use** — taste and real subscription cost

**Benchmark allowlist (only these are scored):**

1. **Artificial Analysis** — all coding-relevant indices, via `aa-fetch.sh`
2. **CursorBench** — scores only, not Cursor's editorial; Cursor-disclosed contaminated scores are dropped

Everything else is unscored. Independent evaluator reports (METR etc.) may add qualitative risk notes next to a rating, never move a score. If an allowlisted composite ever includes a SWE-Bench variant, use the individual non-SWE columns instead.

**Disqualified sources (never counted, in any direction):**

- Anything a model's own provider says about its model — launch posts, self-reported benchmarks, system cards, employee/DevRel posts, partner testimonials.
- SWE-Bench Pro and every SWE-Bench-family benchmark; claims resting on SWE-Bench numbers are out too. (AA's indices are fine — independently run, no SWE-Bench components.)

## 1. Benchmark data (`aa-fetch.sh`)

```sh
AA_API_KEY=... ./aa-fetch.sh              # top 30 by AA Coding Index
AA_API_KEY=... ./aa-fetch.sh -n 60        # top 60
AA_API_KEY=... ./aa-fetch.sh claude       # filter by name
```

(free API key: <https://artificialanalysis.ai/api>)

Columns pulled — agentic benchmarks matter most, since subagents run unsupervised:

| column | benchmark | measures |
|---|---|---|
| `code-idx` | AA Coding Index | composite coding ability |
| `term2.1`, `term-hard` | Terminal-Bench 2.1 / Hard | **agentic coding in a real terminal** |
| `tau2` | tau²-bench | **agentic tool use** |
| `lcb` | LiveCodeBench | competitive coding |
| `sci` | SciCode | scientific code generation |
| `if` | IFBench | instruction following |
| `lcr` | LCR | long context reasoning |
| `intel` | AA Intelligence Index | overall (context only, never the rating) |

## 2. X sentiment research

Use the aside CLI (load the `aside-browser` skill) to search x.com for real-world reports on the model. Filtering rules:

- **Exclude**: sponsored/affiliated accounts, lab ambassadors and partners, launch-day hype threads, engagement farmers, praise without receipts.
- **Include**: independent devs showing actual work — transcripts, diffs, failure reports, longitudinal ("used it for two weeks") takes.
- Negative reports weigh more than positive ones; nobody gets paid to complain.

## 3. Hands-on scoring — internal trial suite

Candidate models are trialed against a **private task holdout** (`run-trial.sh`; tasks live in
`$SUBAGENT_TASKS_DIR`, default `~/.subagent/eval-tasks`, deliberately outside this repo so they
can't end up in training data). Intelligence/agentic tasks are mechanically checked; taste briefs
are human-judged. Only task IDs and pass/fail records are published, in [`trials/`](trials/).
See [`CANDIDATES.md`](CANDIDATES.md) for the graduation protocol.

- **cost** — scored from AA list prices (input-weighted blend, since agentic work is input-heavy), so anyone can reproduce it. Independent receipts about effective price (tokenizer inflation, quota burn) adjust the score. If your subscription makes a model effectively free, bump its cost score locally.
- **taste** — UI/UX output, code quality, API design, copy. No public benchmark measures this; score from real use.

## Updating the rankings / adding a model

1. Run `aa-fetch.sh`, read the full row — weight `term2.1`/`term-hard`/`tau2` highest.
2. Run the X sentiment research (shill-filtered).
3. Score cost from your actual plan; score taste after real use on user-facing work.
4. Synthesize into 1–9 cost/intelligence/taste. When sources disagree: hands-on > sentiment > benchmarks.
5. Update the table in [`skills/subagent/SKILL.md`](../skills/subagent/SKILL.md) (single source of truth).
6. If needed, add a shorthand mapping (`bin/subagent` built-ins or `~/.config/subagent/models`).
7. Bump `VERSION` in `bin/subagent`, commit — users pick it up with `subagent update`.

## Attribution

Benchmark and pricing data: [Artificial Analysis](https://artificialanalysis.ai), used per their [API attribution terms](https://artificialanalysis.ai/api). Not affiliated.
