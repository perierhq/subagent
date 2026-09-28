# CursorBench data pull — 2026-09-27

Source: <https://cursor.com/cursorbench>, **CursorBench 4.0** (introduced 2026-09-10: long-horizon edit,
refactor, investigation, intent understanding, job management, design adherence). Allowlisted per
AGENTS.md. This file records scores only and ignores Cursor's editorial.

The 4.0 scores are on a new task set. Don't compare them with the 3.2 numbers in
`2026-07-10-cursorbench.md` (Fable 5 Max was 70.5% on 3.2; the top 4.0 score is 57.8%).

**Contamination:** the 4.0 page has no contamination disclosures, so no score is dropped. (Grok 4.5's
3.2 contamination ruling is now moot: AA lists the model as deprecated.)

Best effort level per model (score, avg cost/task):

| model | best level | CursorBench 4.0 | $/task | other levels |
|---|---|---:|---:|---|
| Opus 5.5 | Max | 57.8% | $13.43 | XHigh 56.0 ($6.98), High 56.0 ($3.97), Med 52.5, Low 43.7 |
| Fable 5.1 | Max | 51.8% | $17.28 | XHigh 51.6, High 49.2 ($9.08), Med 46.8, Low 45.1 |
| Opus 5 | Max | 46.6% | $11.95 | XHigh 46.1, High 44.7, Med 43.3, Low 40.7 |
| Grok 4.7 | XHigh | 46.3% | $6.01 | High 43.9 ($4.69), Med 41.6, Low 33.1 |
| GPT-5.6 Sol | Max | 41.7% | $8.23 | XHigh 37.7, High 35.7, Med 31.1, Low 24.6 |
| Muse Spark 1.3 | Max | 41.6% | $2.64 | XHigh 37.5, High 33.4, Med 32.6, Low 29.3 |
| Grok 4.6 | XHigh | 41.4% | $6.10 | High 40.4, Med 36.1, Low 33.4 |
| GPT-5.6 Terra | Max | 41.3% | $5.14 | XHigh 33.6 ($1.81), High 30.7, Med 27.6, Low 25.2 |
| Gemini 3.8 Flash | High | 39.6% | $4.70 | Med 37.3 |
| GPT-5.6 Luna | Max | 35.9% | $1.03 | XHigh 33.0 ($0.44), High 29.4, Med 22.2, Low 16.0 |
| Sonnet 5 | Max | 34.1% | $7.17 | XHigh 32.0, High 30.8, Med 28.0, Low 24.1 |
| Composer 2.5 | — | 27.7% | $0.68 | (Cursor's own model: unscored, since this is its provider's benchmark) |

**No CursorBench 4.0 score yet:** GPT-6 Astra, GPT-6 Sol, GPT-6 Luna, Kimi K3.

Changelog notes relevant to cost: Sonnet 5 results were re-priced 2026-08-11, and GPT-5.6 Terra/Luna
were re-priced 2026-07-30 (AA now lists Terra at $2/$12 and GPT-5.6 Luna at $0.20/$1.20).

Cursor's caveat: "Results are subject to variance; small differences in scores may not be statistically meaningful."
