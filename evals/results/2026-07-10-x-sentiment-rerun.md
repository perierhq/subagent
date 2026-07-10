# X sentiment research (rerun) — 2026-07-10 — GPT-5.6 family + Grok 4.5

Rerun under the tightened eval rule: provider statements disqualified entirely (positive AND negative),
SWE-Bench-family benchmarks disqualified. Supersedes the GPT-5.6 and Grok 4.5 sections of
2026-07-10-x-sentiment.md.

Method: aside CLI agent session (logged-in X), per ../../AGENTS.md.

---

I searched logged-in X and filtered hard.

GPT-5.6 family: Sol, Terra, Luna

Overall independent dev sentiment:
Positive for Sol as an agentic daily-driver and cost/performance routing family, but not a clean “best coder” win. Terra/Luna sentiment is much thinner: mostly cost-tier discussion, with some Luna hallucination/correctness complaints.

Credible positive signals:
- @VraserX: “vibe coded a playable FPS game in 1 day with GPT-5.6 Sol”, with attached gameplay video.
- @swader: “verifiably better than Fable” and “switched back”, with screenshot receipt of real coding/PR work.
- Weaker signal, not counted as top because vendor/product-interest: @coderabbitai/@JuanPa said Sol stayed oriented on long repo/code-review work and Terra fit scoped cheaper work.

Credible negative signals:
- @MParakhin, Shopify CTO: after deep testing, said GPT-5.6 was “clearly worse on coding” than Fable, though better on agentic workloads.
- @ahoo_wang: repo-scale complaint that GPT-5.6 in Codex showed 372k context, not 1M, and they would rather have GPT-5.5 with 1M for repo-scale coding. Screenshot attached.
- @Zian14710109: said GPT-5.6 Luna high felt worse than 5.5 for coding and hallucinated. @EuropeMacApps also reported a GPT-5.6 Sol Work-mode memory leak with screenshot.

Taste signals:
- Sol: better follow-through, agentic delegation, long-task persistence.
- Terra: treated as scoped/cost-efficient work lane, not “best coder”.
- Luna: speed/cost tier, but weakest evidence and more correctness skepticism.
- UX/API: naming and mode split confused users; Codex/Work context and quota behavior drew complaints.

Excluded material:
Heavy exclusions. I dropped OpenAI/Sam/GDB/employee posts, launch reposts, news-bot summaries, DeepSWE/Custom SWE-Bench/SWE-family claims, “54% token efficiency” reposts, and early-access/possible partner-style praise unless there was a concrete independent receipt. Roughly 80 to 90 percent of GPT-5.6 hits were unusable.

Confidence:
Medium for “Sol is strong for agentic coding, not clearly best raw coder.” Low for separate Terra/Luna conclusions.

Grok 4.5

Overall independent dev sentiment:
More mixed and more polarized than GPT-5.6. Developers like Grok 4.5 inside Grok Build/Cursor for speed, cost, and practical agentic work, but negative reports cluster around quotas, weak UI tasks, and needing guardrails.

Credible positive signals:
- @jessethanley: said they merged about 12 PRs from Grok 4.5 via Cursor into @Bento, “good and safe” as default only with guardrails. Follow-up screenshots showed a tool issue and then fixed state.
- @alby13: said Grok 4.5 fixed a Rust SNES emulator graphics problem, with video of Star Fox running.
- @ArtificialAnlys: independent evaluator said Grok 4.5 was on par with GPT-5.5 on its Coding Agent Index in Grok Build at lower cost. Not SWE-Bench.

Credible negative signals:
- @houseperu: detailed prompt, errors, mediocre result, burned 100 percent of credits in one night, with video/screenshot.
- @ravikp7: “small UI coding tasks” were bad, worse than Composer.
- @XilDizzle: “did next to nothing” and burned 80 percent of weekly usage, model good but plans too expensive/limited. @fkodomx also found GPT-5.6 Sol consistently but only marginally better, with Grok limits much more restrictive.

Taste signals:
- UI/UX output: weakest area in reports. Small UI coding and visual polish got complaints.
- Code quality/style: good when harnessed with guardrails; not trusted as an unguarded default.
- API/product design: Grok Build/Cursor integration is a major positive. Quota model, plan limits, and usage transparency are the major negatives.

Excluded material:
Dropped xAI/SpaceXAI/Elon/Grok/Cursor launch posts, Elon-amplified posts, SWE-Bench Pro claims, “free in Cursor” engagement threads, obvious AI-news reposts, and generic “insane” praise without repo/diff/screenshot/video. Excluded majority of Grok hits too, around 75 to 85 percent.

Confidence:
Medium. There are real coding receipts, but most are still very early and quota complaints may dominate because people are stress-testing launch access.
