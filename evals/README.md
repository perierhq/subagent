# evals

Evals backing the model rankings in the [README](../README.md#picking-the-right-model). Work in progress.

## Goal

Turn the cost / intelligence / taste table from vibes into measurements, and make it cheap to re-score when new models land.

## Planned structure

```
evals/
  tasks/          # one dir per task: prompt.md + rubric.md + any fixtures
  results/        # <model>/<task>/ raw transcripts + scores
  run.sh          # subagent <model> ... across tasks/, judged by a strong model
```

## Axes

- **intelligence** — hard, unsupervised, verifiable tasks (bugs with failing tests, spec-to-passing-implementation)
- **taste** — UI/UX output, API design, copy; judged pairwise by a strong model + human spot-checks
- **cost** — actual $ per solved task at my subscription rates, not list price

## Adding a model

1. Add a shorthand if needed (`~/.config/subagent/models`).
2. `./run.sh <model>` (once it exists).
3. Update the table in `README.md` and `AGENTS.md`.
