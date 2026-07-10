# evals

The model rankings in [`skills/subagent/SKILL.md`](../skills/subagent/SKILL.md) are not run in-house. Intelligence and list-price data come from [Artificial Analysis](https://artificialanalysis.ai), who benchmark this better than we could; the remaining axes come from hands-on use.

## How the three axes are sourced

| axis | source |
|---|---|
| **intelligence** | Artificial Analysis [Intelligence Index](https://artificialanalysis.ai/models) — bucketed onto the 1–9 scale |
| **cost** | what you *actually pay* (subscription plans, generous provider limits), with AA list prices as the reference point. This is inherently personal — adjust for your own plans. |
| **taste** | hand-scored from real usage (UI/UX output, code quality, API design, copy). Not something public benchmarks measure well; arena-style leaderboards are a weak secondary signal. |

## Updating the rankings / adding a model

1. Fetch current benchmark data:

   ```sh
   AA_API_KEY=... ./aa-fetch.sh            # all models by intelligence index
   AA_API_KEY=... ./aa-fetch.sh claude     # filter by name
   ```

   (free API key: <https://artificialanalysis.ai/api>)

2. Bucket the intelligence index onto 1–9 relative to the models already in the table.
3. Score cost from your actual plan pricing; score taste after real use on user-facing work.
4. Update the table in [`skills/subagent/SKILL.md`](../skills/subagent/SKILL.md) (single source of truth).
5. If needed, add a shorthand to the built-in prefixes in `bin/subagent` or document a `~/.config/subagent/models` mapping.
6. Bump `VERSION` in `bin/subagent`, commit — users pick it up with `subagent update`.

## Attribution

Intelligence and pricing data: [Artificial Analysis](https://artificialanalysis.ai), used per their [API attribution terms](https://artificialanalysis.ai/api). Not affiliated.
