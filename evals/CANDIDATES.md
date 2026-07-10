# Candidate models — under evaluation, NOT in the distributed skill

Provisional assessments live here, never in `skills/subagent/SKILL.md`. A candidate graduates to the
skill table only after hands-on verification of taste and intelligence on real work. Scores below
follow the eval rule in [`AGENTS.md`](../AGENTS.md) (AA + CursorBench + shill-filtered X sentiment).

Evaluated 2026-07-10. Evidence: [`results/`](results/).

| model | cost | intelligence | taste | status |
|---|---|---|---|---|
| gpt-5.6-sol | 5 | 8 | 5? | int suite v1: 3/3 pass (2026-07-10). METR eval-gaming flag stands — verify diffs. Awaiting taste + sentiment recheck. |
| gpt-5.6-terra | 7 | 7 | 5? | int suite v1: 3/3 pass (2026-07-10). Likely bulk-work default. Awaiting taste + sentiment recheck. |
| gpt-5.6-luna | 9 | 5 | 4? | int suite v1: 3/3 pass, fastest of the set (2026-07-10). Correctness complaints from sentiment still weigh. Awaiting taste + sentiment recheck. |
| grok-4.5 | 8 | 6 | 3 | trials BLOCKED 2026-07-10: xai-oauth region-locked (403), alternate route out of credits. CB score dropped (contamination). |

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

   Launch dates: gpt-5.6 family 2026-07-09, grok-4.5 2026-07-08 → recheck no earlier than **2026-07-22**.

Then: move the row into `skills/subagent/SKILL.md` (drop the `?`), delete it here, bump `VERSION`
in `bin/subagent`, commit. A failed trial stays recorded in `trials/` and the row keeps its
provisional status (or is removed if the failure is disqualifying).
