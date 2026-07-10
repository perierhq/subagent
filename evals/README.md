# evals

The model rankings in [`skills/subagent/SKILL.md`](../skills/subagent/SKILL.md) are not run in-house. They synthesize three inputs, per the eval rule in [`AGENTS.md`](../AGENTS.md):

1. **[Artificial Analysis](https://artificialanalysis.ai) coding benchmarks** — all of them, not just the Intelligence Index
2. **Shill-filtered public sentiment from X** — what independent practitioners actually report
3. **Hands-on use** — taste and real subscription cost

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

## 3. Hands-on scoring

- **cost** — what you *actually pay* (subscription plans, provider limits), with AA list prices as reference. Inherently personal; adjust for your own plans.
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
