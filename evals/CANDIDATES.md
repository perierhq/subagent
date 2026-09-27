# Candidate models — under evaluation, NOT in the distributed skill

Provisional assessments live here, never in `skills/subagent/SKILL.md`. A candidate graduates to the
skill table only after hands-on verification of taste and intelligence on real work. Scores below
follow the eval rule in [`AGENTS.md`](../AGENTS.md) (AA + CursorBench + shill-filtered X sentiment).

Last updated 2026-09-27. Evidence: [`results/`](results/).

**Skill is stale (2026-09-27):** AA marks five of the seven rows in `skills/subagent/SKILL.md` as
deprecated, with successors: gpt-5.5 → gpt-5.6-sol → gpt-6-sol, opus-4.8 → opus-5 → opus-5.5,
fable-5 → fable-5.1, gpt-5.6-sol → gpt-6-sol, gpt-5.6-luna → gpt-6-luna. Only gpt-5.6-terra and
sonnet-5 are current. The successors below are the priority for graduation.

**Graduated 2026-07-10 (owner decision, early):** gpt-5.6-sol, gpt-5.6-terra, gpt-5.6-luna, each
passing the int suite 3/3 plus model-judged taste trials. The 2026-07-22 post-ship sentiment audit
has no record in `results/`.

Round 2026-09-27 is **benchmark-only** (AA website + v2 API, CursorBench 4.0). This environment had
no `pi`, no private suite and no X access, so taste is `?` and intelligence scores are benchmark-provisional
until the int suite and sentiment recheck run.

| model | cost | intelligence | taste | status |
|---|---|---|---|---|
| opus-5.5 | 5 | 9 | ? | released 2026-09-22. #1 on AA intel (58) and Terminal-Bench 4.0 (60, tied), #1 CursorBench 4.0 (57.8% Max; 56.0% at High for $3.97/task). $4/$20 is cheaper than opus-4.8, but it's very verbose at max (AA: 260M output tokens vs 88M median); high effort is the value point ($1.82/AA task). Successor to opus-4.8. Sentiment recheck ≥ 2026-10-06. |
| fable-5.1 | 3 | 9 | ? | released 2026-09-01. AA intel 53, term4.0 55, term2.1 91, CB 4.0 51.8% ($17.28/task, the most expensive entry). Successor to fable-5 (taste 9). Now *below* opus-5.5 on every allowlisted agentic number at 2.5× the list price, so the "fable = best model" guidance needs re-checking. Recheck eligible now. |
| gpt-6-astra | 3 | 9 | ? | released 2026-09-03. OpenAI's new top tier at $10/$50. AA intel 53, term4.0 60 (xhigh, tied top), term2.1 89, tau3-bank 43. **No CursorBench score yet**, so this rests on AA only. Recheck eligible now. |
| gpt-6-sol | 7 | 8 | ? | released 2026-09-22. $2/$10, half the price of gpt-5.6-sol. AA intel 48, term4.0 44 at max but it drops steeply (xhigh 30, high 26), so run it at max for agentic work. No CB score yet. Successor to gpt-5.6-sol and gpt-5.5. Recheck ≥ 2026-10-06; check whether METR's eval-gaming flag on 5.6-sol carries over. |
| gpt-6-luna | 9 | 5 | ? | released 2026-09-22. $0.10/$0.50 (half of 5.6-luna), same tier: AA intel 37, term4.0 13. Successor to gpt-5.6-luna. Recheck ≥ 2026-10-06. |
| grok-4.7 | 7 | 7 | ? | released 2026-09-21. $2/$6 list price but verbose ($3.74/AA task at max, so cost 7 rather than 8). AA intel 46, term4.0 26; CB 4.0 46.3% XHigh, the best non-Anthropic entry on CB. The grok-4.5 reviewer-calibration warning still applies until sentiment says otherwise. Recheck ≥ 2026-10-05. |
| muse-spark-1.3 | 8 | 7 | ? | released 2026-09-02 (Meta). $1.25/$4.25. AA intel 48, term4.0 33, tau3-bank 51 (top), CB 4.0 41.6% at $2.64/task. Needs a shorthand mapping and a pi provider before trials. Recheck eligible now. |
| gemini-3.8-flash | 8 | 6 | ? | released 2026-09-02. $0.75/$3.75, but very verbose on CB ($4.70/task, 162k tokens), so cost 8. AA intel 41, term4.0 20, term2.1 88, CB 39.6%. A candidate for the bulk tier against gpt-5.6-terra. Needs a shorthand mapping and a pi provider. Recheck eligible now. |
| kimi-k3 | 5 | 7 | 7 | full eval 2026-07-17 (via its creator's API): int 3/3, top-tier UI trial and a sophisticated API doc. AA code-idx 76, term2.1 85, intel 44, LCR 89 (highest in the snapshot). **2026-09-27 risk note:** AA Terminal-Bench 4.0 is only 13, weak on the new long-horizon agentic eval. Intelligence stays 7 (one benchmark doesn't outweigh the hands-on 3/3); re-score if a new int-suite run or sentiment confirms it. No CursorBench score. Earlier caveats still apply: extreme latency and verbosity (32 min for one page), plus complex-task error reports. |

Removed 2026-09-27: **grok-4.5**, which AA lists as deprecated (→ grok-4.6 → grok-4.7). Its reviewer-calibration
finding carries over as a risk note on grok-4.7.

`?` = taste unverified (no hands-on yet).

## Graduation protocol (per model)

A candidate graduates only when all three pass. Record each trial in [`trials/`](trials/) using the template.

1. **Intelligence — internal task suite.** Run the private holdout tasks (`./run-trial.sh <model>
   v1/int-1`, `v1/int-2`, `v1/agent-1`) — mechanically checked (tests + invariants), reproducible,
   and private so models can't train on them (same reason CursorBench keeps its tasks secret).
   Task content lives in the private sibling repo `subagent-evals` (clone next to this repo), never here; only task IDs and pass/fail results are public in `trials/`. Supplement with real-work
   tasks when they come up — real work always outranks the suite.
2. **Taste — internal briefs + human judgment.** `./run-trial.sh <model> v1/taste-1` (UI) and
   `v1/taste-2` (API design); the runner records the output for human blind-compare against the
   incumbent. A verified taste≥8 model (fable-5/opus-4.8) may screen, but the score is a human call.

   Suites are versioned; results are only comparable within a suite version. If a model aces the
   suite but underperforms on real work, assume the suite leaked and rotate to a new version.
3. **Sentiment recheck — ≥2 weeks after model launch.** Rerun the shill-filtered X research
   (launch-week data only samples hype and stress-tested quotas). Look specifically for: nerf
   and regression reports, quota tightening, "switched back" takes.

   Launch dates: fable-5.1 2026-09-01, muse-spark-1.3 / gemini-3.8-flash 2026-09-02, gpt-6-astra 2026-09-03
   → recheck eligible now. grok-4.7 2026-09-21, opus-5.5 / gpt-6-sol / gpt-6-luna 2026-09-22 → recheck no
   earlier than **2026-10-06**.

Then: move the row into `skills/subagent/SKILL.md` (drop the `?`), delete it here, bump `VERSION`
in `bin/subagent`, commit. A failed trial stays recorded in `trials/` and the row keeps its
provisional status (or is removed if the failure is disqualifying).
