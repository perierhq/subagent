# AA benchmark snapshot — 2026-09-27

Source: [Artificial Analysis](https://artificialanalysis.ai) (independent LLM benchmarks), read from the
public model pages (the leaderboard data embedded in `artificialanalysis.ai/models/<slug>`), then
cross-checked against the v2 API with `aa-fetch.sh`. The API values match. **Terminal-Bench 4.0 isn't
in the API**, so that column only comes from the website.

**AA changed its suite since the 2026-07-10 snapshot** (Intelligence Index v4.3.2):

- **Terminal-Bench 4.0** (`term4.0`) is the headline agentic-coding eval now. Weight it highest.
- **τ³-Banking** (`tau3-bank`) replaces tau²-bench for agentic tool use.
- **Coding Index, IFBench and LiveCodeBench** are `null` in the API for models released after
  mid-August 2026 (Opus 5.5, GPT-6 Sol/Luna, Grok 4.7). The old `aa-fetch.sh` filtered on Coding
  Index, so it silently dropped those models. Fixed in the same commit as this file.
- Intelligence Index values were rescaled. Don't compare them with the July snapshot (Fable 5
  was 60 then and is 50 now).

`status` is AA's own flag. "deprecated → X" means AA lists X as the successor. All values are 0–100;
`$/II task` is AA's weighted cost per Intelligence Index task, which includes verbosity. Top three
effort levels per model:

| model (AA variant) | released | status | intel | term4.0 | term2.1 | tau3-bank | sci | lcr | $/1M in | $/1M out | $/II task |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Claude Opus 5.5 (max with fallback) | 2026-09-22 | current | 58 | 60 | - | - | 67 | 85 | 4 | 20 | 5.98 |
| Claude Opus 5.5 (xhigh with fallback) | 2026-09-22 | current | 56 | 60 | - | - | 65 | 85 | 4 | 20 | 3.46 |
| Claude Opus 5.5 (high with fallback) | 2026-09-22 | current | 54 | 57 | - | - | 60 | 83 | 4 | 20 | 1.82 |
| Claude Fable 5.1 (max with fallback) | 2026-09-01 | current | 53 | 52 | 91 | 47 | 63 | 85 | 10 | 50 | 7.63 |
| Claude Fable 5.1 (xhigh with fallback) | 2026-09-01 | current | 53 | 55 | 91 | 46 | 61 | 83 | 10 | 50 | 5.98 |
| GPT-6 Astra (max) | 2026-09-03 | current | 53 | 59 | 88 | 41 | 56 | 81 | 10 | 50 | 3.26 |
| GPT-6 Astra (xhigh) | 2026-09-03 | current | 52 | 60 | 89 | 43 | 56 | 80 | 10 | 50 | 2.31 |
| Claude Opus 5.5 (medium with fallback) | 2026-09-22 | current | 51 | 53 | - | - | 59 | 84 | 4 | 20 | 1.34 |
| Claude Fable 5.1 (high with fallback) | 2026-09-01 | current | 51 | 52 | 90 | 43 | 59 | 84 | 10 | 50 | 3.91 |
| GPT-6 Astra (high) | 2026-09-03 | current | 51 | 54 | 90 | 40 | 55 | 80 | 10 | 50 | 1.73 |
| Claude Opus 5 (max) | 2026-07-24 | deprecated → claude-opus-5-5 | 51 | 49 | 89 | 42 | 56 | 79 | 5 | 25 | 5.86 |
| Claude Opus 5 (xhigh) | 2026-07-24 | deprecated → claude-opus-5-5-xhigh | 50 | 46 | 88 | 43 | 56 | 80 | 5 | 25 | 4.88 |
| Claude Fable 5 (with fallback) | 2026-06-09 | deprecated → claude-fable-5-1 | 50 | 42 | 85 | 38 | 61 | 82 | 10 | 50 | 8.75 |
| GPT-6 Astra (medium) | 2026-09-03 | current | 50 | 49 | 90 | 35 | 54 | 80 | 10 | 50 | 1.54 |
| Claude Fable 5.1 (medium with fallback) | 2026-09-01 | current | 49 | 45 | 88 | 41 | 56 | 85 | 10 | 50 | 2.98 |
| Claude Opus 5 (high) | 2026-07-24 | deprecated → claude-opus-5-5-high | 48 | 46 | 88 | 45 | 55 | 79 | 5 | 25 | 3.61 |
| Muse Spark 1.3 (max) | 2026-09-02 | current | 48 | 33 | 84 | 51 | 59 | 83 | 1.25 | 4.25 | 1.60 |
| GPT-6 Sol (max) | 2026-09-22 | current | 48 | 44 | - | - | 58 | 84 | 2 | 10 | 1.06 |
| GPT-5.6 Sol (max) | 2026-07-09 | deprecated → gpt-6-sol | 47 | 40 | 88 | 44 | 57 | 84 | 4 | 20 | 1.99 |
| Grok 4.7 (xhigh) | 2026-09-21 | current | 46 | 26 | - | - | 57 | 77 | 2 | 6 | 3.74 |
| Grok 4.7 (high) | 2026-09-21 | current | 46 | 25 | - | - | 58 | 77 | 2 | 6 | 2.73 |
| Muse Spark 1.3 (xhigh) | 2026-09-02 | current | 45 | 17 | 85 | 47 | 60 | 83 | 1.25 | 4.25 | 1.37 |
| Claude Opus 5 (medium) | 2026-07-24 | deprecated → claude-opus-5-5-medium | 45 | 34 | 86 | 39 | 52 | 82 | 5 | 25 | 2.19 |
| Grok 4.6 (high) | 2026-08-12 | current | 44 | 21 | 88 | 51 | 56 | 80 | 2 | 6 | 1.86 |
| Grok 4.6 (xhigh) | 2026-08-12 | current | 44 | 17 | 88 | 43 | 53 | 81 | 2 | 6 | 2.32 |
| GPT-6 Sol (xhigh) | 2026-09-22 | current | 44 | 30 | - | - | 55 | 81 | 2 | 10 | 0.53 |
| GPT-5.6 Sol (xhigh) | 2026-07-09 | deprecated → gpt-6-sol-xhigh | 44 | 25 | 90 | 38 | 57 | 82 | 4 | 20 | 1.18 |
| Kimi K3 (max) | 2026-07-16 | current | 44 | 13 | 85 | 46 | 59 | 89 | 3 | 15 | 2.00 |
| Grok 4.6 (medium) | 2026-08-12 | current | 43 | 13 | 84 | 44 | 56 | 81 | 2 | 6 | 1.50 |
| GPT-6 Sol (high) | 2026-09-22 | current | 43 | 26 | - | - | 55 | 84 | 2 | 10 | 0.37 |
| GPT-5.6 Sol (high) | 2026-07-09 | deprecated → gpt-6-sol-high | 42 | 21 | 87 | 37 | 58 | 82 | 4 | 20 | 0.81 |
| GPT-5.6 Terra (max) | 2026-07-09 | current | 42 | 35 | 88 | 40 | 55 | 83 | 2 | 12 | 1.40 |
| Claude Opus 4.8 (max) | 2026-05-28 | deprecated → claude-opus-5 | 42 | 22 | 85 | 34 | 54 | 78 | 5 | 25 | 4.08 |
| Gemini 3.8 Flash (high) | 2026-09-02 | current | 41 | 20 | 88 | 45 | 57 | 81 | 0.75 | 3.75 | 1.24 |
| GPT-6 Sol (medium) | 2026-09-22 | current | 40 | 19 | - | - | 54 | 82 | 2 | 10 | 0.25 |
| Gemini 3.8 Flash (medium) | 2026-09-02 | current | 40 | 20 | 84 | 46 | 55 | 84 | 0.75 | 3.75 | 0.93 |
| GPT-5.6 Sol (medium) | 2026-07-09 | deprecated → gpt-6-sol-medium | 39 | 15 | 86 | 36 | 57 | 80 | 4 | 20 | 0.50 |
| Grok 4.5 (high) | 2026-07-08 | deprecated → grok-4-6 | 39 | 11 | 82 | 42 | 55 | 79 | 2 | 6 | 1.04 |
| GPT-5.5 (xhigh) | 2026-04-23 | deprecated → gpt-5-6-sol-xhigh | 38 | 15 | 84 | 39 | 56 | 84 | 5 | 30 | 2.63 |
| Claude Sonnet 5 (max) | 2026-06-30 | current | 38 | 14 | 81 | 37 | 54 | 82 | 2 | 10 | 5.09 |
| GPT-5.6 Terra (xhigh) | 2026-07-09 | current | 38 | 10 | 80 | 30 | 52 | 79 | 2 | 12 | 0.63 |
| GPT-5.6 Luna (max) | 2026-07-09 | deprecated → gpt-6-luna | 37 | 12 | 81 | 31 | 54 | 84 | 0.2 | 1.2 | 0.18 |
| GPT-6 Luna (max) | 2026-09-22 | current | 37 | 13 | - | - | 55 | 83 | 0.1 | 0.5 | 0.07 |
| GPT-5.5 (high) | 2026-04-23 | deprecated → gpt-5-6-sol-high | 37 | 9 | 79 | 37 | 56 | 84 | 5 | 30 | 1.54 |
| GPT-5.6 Luna (xhigh) | 2026-07-09 | deprecated → gpt-6-luna-xhigh | 35 | 4 | 78 | 29 | 50 | 82 | 0.2 | 1.2 | 0.09 |
| Claude Sonnet 5 (xhigh) | 2026-06-30 | current | 34 | 7 | - | - | 54 | 77 | 2 | 10 | 2.87 |
| GPT-5.6 Terra (high) | 2026-07-09 | current | 34 | 2 | 76 | 29 | 52 | 78 | 2 | 12 | 0.34 |
| GPT-6 Luna (xhigh) | 2026-09-22 | current | 34 | 8 | - | - | 52 | 80 | 0.1 | 0.5 | 0.04 |
| GPT-5.5 (medium) | 2026-04-23 | deprecated → gpt-5-6-sol-medium | 34 | 5 | 81 | 30 | 55 | 83 | 5 | 30 | 0.90 |
| GPT-6 Luna (high) | 2026-09-22 | current | 32 | 5 | - | - | 50 | 79 | 0.1 | 0.5 | 0.03 |
| GPT-5.6 Luna (high) | 2026-07-09 | deprecated → gpt-6-luna-high | 32 | 3 | 70 | 25 | 52 | 80 | 0.2 | 1.2 | 0.04 |
| Claude Sonnet 5 (high) | 2026-06-30 | current | 32 | 5 | - | - | 54 | 77 | 2 | 10 | 1.79 |
| GPT-5.6 Terra (medium) | 2026-07-09 | current | 30 | 1 | 72 | 26 | 50 | 74 | 2 | 12 | 0.18 |
| GPT-6 Luna (medium) | 2026-09-22 | current | 29 | 3 | - | - | 51 | 78 | 0.1 | 0.5 | 0.02 |
| Claude Sonnet 5 (medium) | 2026-06-30 | current | 28 | 2 | - | - | 52 | 74 | 2 | 10 | 1.00 |
| GPT-5.6 Luna (medium) | 2026-07-09 | deprecated → gpt-6-luna-medium | 25 | 1 | 53 | 18 | 47 | 75 | 0.2 | 1.2 | 0.02 |

Coding Index and output speed from the API (`aa-fetch.sh`), for models that still have the index.
Highest effort level shown:

| model | code-idx | tok/s |
|---|---|---|
| Claude Fable 5.1 (max) | 82 | 71 |
| GPT-6 Astra (max / high) | 77 / 77 | 62 / 57 |
| GPT-5.6 Terra (max) | 77 | 98 |
| Muse Spark 1.3 (xhigh / max) | 77 / 76 | 333 / 164 |
| Gemini 3.8 Flash (high) | 76 | 304 |
| Kimi K3 (max) | 76 | 35 |
| Grok 4.6 (high) | 77 | 79 |
| Claude Sonnet 5 (max) | 72 | 87 |
| Claude Opus 5.5 (max) | — (not published) | 99 |
| GPT-6 Sol (max) | — | 87 |
| GPT-6 Luna (max) | — | 152 |
| Grok 4.7 (xhigh) | — | 71 |

Source: Artificial Analysis <https://artificialanalysis.ai> (independent LLM benchmarks).
