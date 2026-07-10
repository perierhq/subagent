# Candidate models — under evaluation, NOT in the distributed skill

Provisional assessments live here, never in `skills/subagent/SKILL.md`. A candidate graduates to the
skill table only after hands-on verification of taste and intelligence on real work. Scores below
follow the eval rule in [`AGENTS.md`](../AGENTS.md) (AA + CursorBench + shill-filtered X sentiment).

Evaluated 2026-07-10. Evidence: [`results/`](results/).

| model | cost | intelligence | taste | status |
|---|---|---|---|---|
| gpt-5.6-sol | 5 | 8 | 5? | agentic > raw coding (CB 67.2, AA term2.1 90); ⚠️ METR flagged the highest eval-gaming rate they've measured — verify diffs. Awaiting hands-on. |
| gpt-5.6-terra | 7 | 7 | 5? | CB Max 64.9 (above opus-4.8), AA code-idx 77 at half sol's price. Likely bulk-work default once verified. |
| gpt-5.6-luna | 9 | 5 | 4? | benchmarks okay at Max effort (CB 61.1) but independent correctness complaints; sentiment > benchmarks. |
| grok-4.5 | 8 | 6 | 3 | CursorBench score dropped (contamination, Cursor's own disclosure) — rests on AA + sentiment. Real receipts exist with guardrails; UI output documented weak. |

`?` = taste unverified (no hands-on yet).

## Graduation protocol (per model)

A candidate graduates only when all three pass. Record each trial in [`trials/`](trials/) using the template.

1. **Intelligence — real bulk task.** Route a real task from actual work to the candidate
   (`subagent <candidate> --bg trial-<name> @spec.md`), not a synthetic exercise — synthetic
   mini-benches are our own contamination. Verifiable outcome required (tests pass, invariants
   hold). Pass = output meets the bar you'd accept from the incumbent for that task class.
2. **Taste — real user-facing task.** UI component, API design, or copy. Optionally run the same
   task on the incumbent and blind-compare. A verified taste≥8 model (fable-5/opus-4.8) may
   screen/review, but the score is a human call.
3. **Sentiment recheck — ≥2 weeks after model launch.** Rerun the shill-filtered X research
   (launch-week data only samples hype and stress-tested quotas). Look specifically for: nerf
   and regression reports, quota tightening, "switched back" takes.

   Launch dates: gpt-5.6 family 2026-07-09, grok-4.5 2026-07-08 → recheck no earlier than **2026-07-22**.

Then: move the row into `skills/subagent/SKILL.md` (drop the `?`), delete it here, bump `VERSION`
in `bin/subagent`, commit. A failed trial stays recorded in `trials/` and the row keeps its
provisional status (or is removed if the failure is disqualifying).
