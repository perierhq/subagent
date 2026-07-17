# X sentiment + CursorBench — 2026-07-17 — Kimi K3, Grok 4.5 (post-launch)

Method: aside CLI (logged-in X + web), per eval rule: provider statements and SWE-Bench family
disqualified; ~120/128 posts per model excluded as hype/shill/receipt-less.
Kimi K3 accessed via its creator's API (Moonshot). Grok 4.5 now usable (xai-oauth unblocked).

---

## Kimi K3

**Overall independent sentiment:** Very early and fragile. The credible signal is “strong at visual/frontend prototyping,” but not yet trustworthy evidence of production-repo quality; the few direct negatives are more diagnostic than the demos. Artificial Analysis currently gives it a 57 Intelligence Index, but also observed 130M output tokens across its evaluation, suggesting a verbose, potentially costly agent loop. (quote: Artificial Analysis lists Kimi K3 at 57 Intelligence Index and 130M evaluation output tokens.)

**Credible positives**
- [@cobi_bean](https://x.com/cobi_bean/status/2078108596135469235): video of a recovery-agent run migrating a broken session DB during a VPS-to-Mac move. Useful real-world repair task, though not a public diff.
- [@johnhe1123](https://x.com/johnhe1123/status/2077989760157528100): video receipt of a working GitHub Trending explorer with charts, filters, repo modals and CN/EN i18n, claimed from one conversation.
- [@chikitleung](https://x.com/chikitleung/status/2078114064451223821): linked playable 3D web chess prototype, claimed as agent-written in about two hours. Prototype evidence only, not production proof.

**Credible negatives**
- [@makio64](https://x.com/makio64/status/2078107525514436795), a Three.js/frontend specialist: likes its UX ideas and agent system, but reports weaker quality than Sol/Fable, many complex-task mistakes, and fast token burn.
- [@KrabArena](https://x.com/krabarena/status/2078098854059110871): coding-API smoke test reportedly got only 1/5 first-call passes, citing rate limits/truncation. Small sample, but exactly the failure mode that matters for agents.

**Taste signals**
- **UI/UX:** unusually good frontend and product ideas, based on the visible app/game demos.
- **Code style:** looks strong for prototyping; the available negative report says complex work becomes error-prone.
- **API/agent ergonomics:** launch-day rate-limit/truncation report plus independent high output-token use are warning signs for unattended loops.

**Exclusion volume:** screened **127 unique X posts**; withheld roughly **120** as launch hype, benchmark reposts, unreceipted praise, provider-adjacent material, or SWE-Bench-dependent claims.

**Confidence:** **Low.** It is essentially day-one evidence.

---

## Grok 4.5

**Overall independent sentiment:** A credible fast, cheap execution model, but not a reliable autonomous reviewer or planner. The strongest independent code-review experiment found it completed the task end-to-end but produced 10 findings of which only 2 were real, including invented tool/task IDs. (quote: In a self-integration code review, Grok 4.5 produced ten findings; two were real and seven did not survive verification.) Artificial Analysis independently lists 54 Intelligence Index and 97.3 output tokens/sec, consistent with the “fast hands” reputation. (quote: Artificial Analysis lists Grok 4.5 high at 54 Intelligence Index and 97.3 output tokens/sec.)

**Credible positives**
- [@simworld_ai](https://x.com/simworld_ai/status/2075329449000886582): video of a UE5 cyberpunk street built with Grok Build; reports 36.5 minutes, 10.75M tokens and about $12.40. Strongest visible build receipt found.
- [@wizardbrainz](https://x.com/wizardbrainz/status/2075589512546464118): game-dev video; says Grok fixed issues that GPT-5.5 and Fable had struggled with.
- [@dorukancs](https://x.com/dorukancs/status/2077370975109226930): screenshot of a working menu-bar quota app, reportedly built in under 30 minutes.

**Credible negatives**
- [@MatthewZRuiz](https://x.com/MatthewZRuiz/status/2077813716314128668), building with Next.js, React Native and Express: no improvement over Composer 2.5; asks fewer clarifying questions but often returns incomplete or short-sighted code.
- [@Trion129](https://x.com/Trion129/status/2077889882790445196), Senior SWE at Uber: screenshot-backed complaint that both work quality and quantity were worse, despite not using it heavily.
- [@tiagochico](https://x.com/tiagochico/status/2078067210115797119): screenshot shows a limit/error via OpenCode even though their stated usage limit had not been reached.

**Taste signals**
- **UI/UX:** speed is the dominant positive. That is partly harness-dependent, so I would not treat Cursor or Grok Build UX praise as a pure model advantage.
- **Code style:** fast execution, but a tendency to skip clarification maps to short-sighted code. In review, it appears high-recall but badly calibrated.
- **API design:** the independent review found it straightforward to wire into a BYO-model launcher; practical subscription limits remain opaque and, for some users, shared across coding/chat/media.

**Exclusion volume:** screened **128 unique X posts**; withheld roughly **120** as hype, provider ecosystem material, unsupported benchmark chatter, or no-receipt praise.

**Confidence:** **Medium.** Nine days of direct-use reports plus one strong independent review, but still a short post-launch window.

---

## CursorBench, scores only

- **Kimi K3:** **no published CursorBench row** currently. The table includes Kimi K2.7 Code, not K3.
- **Grok 4.5:** High **66.7%**, Medium **65.4%**, Low **63.5%**.
- **Contamination:** Cursor marks all three Grok 4.5 results with an asterisk: an earlier Cursor-codebase snapshot was accidentally in training; Cursor says the score impact is unknown. I therefore did **not** use these scores as sentiment evidence. (quote: CursorBench lists Grok 4.5 High 66.7%, Medium 65.4%, Low 63.5%, with a training-contamination warning of unknown impact.)
