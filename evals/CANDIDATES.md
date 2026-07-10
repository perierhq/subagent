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

## Graduation checklist (per model)

- [ ] Hands-on: at least one real bulk/mechanical task (int check)
- [ ] Hands-on: at least one user-facing task (taste check)
- [ ] Re-check sentiment ≥2 weeks post-launch (nerf/regression reports)
- [ ] Add row to `skills/subagent/SKILL.md`, remove from this file, bump `VERSION`
