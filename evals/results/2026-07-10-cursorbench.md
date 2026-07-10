# CursorBench data pull — 2026-07-10

Source: cursor.com/cursorbench (CursorBench 3.2, published 2026-07-08/09) via aside CLI research.
Allowlisted benchmark per AGENTS.md. Scores only; Cursor editorial ignored.

**Ruling: Grok 4.5's CursorBench score is DROPPED** — Cursor disclosed an earlier snapshot of their
codebase was unintentionally in its training data.

Plain text table:

| Model | Published CursorBench score(s) | Publication date | Source URL |
|---|---:|---|---|
| GPT-5.5 | CursorBench 3.2: High 58.4%, Extra High 58.4%, Medium 53.8%, Low 46.6%. Earlier Cursor X post: 72.8%. | Jul 8, 2026 for 3.2 page; Apr 24, 2026 for X post | https://cursor.com/cursorbench and https://x.com/cursor_ai/status/2047744579127185843 (quote: “GPT-5.5 High 58.4% … GPT-5.5 Extra High 58.4% … GPT-5.5 Medium 53.8% … GPT-5.5 Low 46.6%”) (quote: “GPT-5.5 is now available in Cursor! It's currently the top model on CursorBench at 72.8%.”) |
| GPT-5.6 Sol | CursorBench 3.2: Max 67.2%, Extra High 64.5%, High 63.5%, Medium 60.0%, Low 52.6%. Cursor X also posted Sol 67.2%. | Jul 9, 2026 | https://cursor.com/cursorbench and https://x.com/cursor_ai/status/2075265504105611674 (quote: “GPT-5.6 Sol Max 67.2% … GPT-5.6 Sol Extra High 64.5% … GPT-5.6 Sol High 63.5% … GPT-5.6 Sol Medium 60.0% … GPT-5.6 Sol Low 52.6%”) (quote: “GPT-5.6 Sol, Terra, and Luna are now available in Cursor. On CursorBench, Sol scores 67.2%.”) |
| GPT-5.6 Terra | CursorBench 3.2: Max 64.9%, Extra High 59.2%, High 54.2%, Medium 50.3%, Low 46.9%. | Jul 9, 2026 | https://cursor.com/cursorbench (quote: “GPT-5.6 Terra Max 64.9% … GPT-5.6 Terra Extra High 59.2% … GPT-5.6 Terra High 54.2% … GPT-5.6 Terra Medium 50.3% … GPT-5.6 Terra Low 46.9%”) |
| GPT-5.6 Luna | CursorBench 3.2: Max 61.1%, Extra High 57.7%, High 56.8%, Medium 47.7%, Low 37.6%. | Jul 9, 2026 | https://cursor.com/cursorbench (quote: “GPT-5.6 Luna Max 61.1% … GPT-5.6 Luna Extra High 57.7% … GPT-5.6 Luna High 56.8% … GPT-5.6 Luna Medium 47.7% … GPT-5.6 Luna Low 37.6%”) |
| Claude Sonnet 5 | CursorBench 3.2: Max 61.5%, Extra High 58.7%, High 56.9%, Medium 52.4%, Low 47.7%. Earlier Cursor X post: 57% vs Sonnet 4.6 at 49%. | Jul 8, 2026 for 3.2 page; Jun 30, 2026 for X post | https://cursor.com/cursorbench and https://x.com/cursor_ai/status/2072020786181988418 (quote: “Sonnet 5 Max 61.5% … Sonnet 5 Extra High 58.7% … Sonnet 5 High 56.9% … Sonnet 5 Medium 52.4% … Sonnet 5 Low 47.7%”) (quote: “Claude Sonnet 5 is now available in Cursor. On CursorBench, it's a meaningful step up from Sonnet 4.6: 57% vs. 49%.”) |
| Claude Opus 4.8 | CursorBench 3.2: Max 62.3%, Extra High 59.4%, High 58.0%, Medium 56.1%, Low 53.1%. | Jul 8, 2026 | https://cursor.com/cursorbench (quote: “Opus 4.8 Max 62.3% … Opus 4.8 Extra High 59.4% … Opus 4.8 High 58.0% … Opus 4.8 Medium 56.1% … Opus 4.8 Low 53.1%”) |
| Claude Fable 5 | CursorBench 3.2: Max 70.5%, Extra High 68.4%, High 66.5%, Medium 65.2%, Low 62.1%. Earlier Cursor X post: 72.9%. | Jul 8, 2026 for 3.2 page; Jun 9, 2026 for X post | https://cursor.com/cursorbench and https://x.com/cursor_ai/status/2064394824313376787 (quote: “Fable 5 Max 70.5% … Fable 5 Extra High 68.4% … Fable 5 High 66.5% … Fable 5 Medium 65.2% … Fable 5 Low 62.1%”) (quote: “Claude Fable 5 is now available in Cursor. It sets a new state of the art on CursorBench at 72.9%.”) |
| Grok 4.5 | CursorBench 3.2: High 66.7%, Medium 65.4%, Low 63.5%. | Jul 8, 2026 | https://cursor.com/cursorbench (quote: “Grok 4.5 High 66.7% … Grok 4.5 Medium 65.4% … Grok 4.5 Low 63.5%”) |

Contamination / caveat notes:
- Grok 4.5 is explicitly contaminated on CursorBench: Cursor says an earlier snapshot of the Cursor codebase was unintentionally included in training, the score impact is unclear, and that data has been removed for future models. (quote: “Grok 4.5 has an advantage on CursorBench: an earlier snapshot of the Cursor codebase was unintentionally included in training. The exact score impact is unclear.”)
- Cursor says CursorBench 3.2 was introduced Jul 8, 2026, and GPT-5.6 Sol/Terra/Luna results were updated Jul 9, 2026 to account for cache write costs. (quote: “Updated GPT-5.6 Sol, Terra, and Luna results to account for cache write costs.”)
- Cursor warns results are subject to variance and small score differences may not be statistically meaningful. (quote: “Results are subject to variance; small differences in scores may not be statistically meaningful.”)

Models with no published CursorBench score:
- None among the requested models.
