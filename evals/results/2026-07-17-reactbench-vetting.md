# ReactBench vetting — 2026-07-17

Due-diligence on reactbench.com (Million / YC) as a potential allowlist source.

**RULING: not allowlisted.** Reasons:
1. Task folders, verifier files AND solutions are public on GitHub → post-release training
   contamination is immediate — the same disease that disqualified SWE-Bench.
2. Labs are offered early access to held-out tasks with no disclosure framework (who, when, embargo).
3. Scores partly measure compliance with Million's own React Doctor product rules — product-aligned metric.
4. Tiny corpus (51 tasks × 5 trials), no confidence intervals, top spots statistically indistinguishable.
5. Launch-day amplification by an OpenAI co-founder while an OpenAI model tops the board — not
   disqualifying alone, but unearned trust is not on offer.

What it gets right (worth copying into our own closed suite): deterministic hidden behavior tests,
no LLM judge, tasks derived from real merged PRs, pass@1 over multiple trials.

Revisit if they establish a durable private holdout + early-access disclosure.

---

ry ReactBench docs, site, ownership, methodology and leaderboard evidence
- [completed] affiliation: Check affiliations, sponsors, launch partnerships and commercial signals
- [completed] independent: Find independent developer discussion on X and assess credibility claims
- [completed] synthesize: Deliver terse sourced diligence with caveats and gaps
Thinking: **Establishing inline citation format**

**Compiling top 10 leaderboard configurations**

**Clarifying model evaluation discrepancies**

**Inspecting public evaluation data completeness**



repl(title: 'Confirming public reference solutions',
     code: "const r15=await fetch('https://api.github.com/repos/millionco/reactbench/contents/tasks/docusaurus-tabs-11733/solution'); const j15=await r15.json(); const r16=await fetch('https://api.github.com/repos/millionco/reactbench/contents/tasks/docusaurus-tabs-11733/tests'); const j16=await r16.json(); console.log({solution:j15.map(x=>x.name),tests:j16.map(x=>x.name)});") [call_RNdnrDkX6ptDtFmzoDAWRgTb|fc_0995f11c3f09ac71016a5a65a0cd008191b3faa7ecfe8a80fd]

 > {
  solution: [ 'solve.sh', 'src.patch' ],
  tests: [
    'Dockerfile',
    'bake-verifier-state.sh',
    'config.json',
    'grader.mjs',
    'harness',
    'pre-artifacts.sh',
    'test.sh'
  ]
}
Thinking: **Clarifying public URL task and leaderboard**

**Planning leaderboard screenshot inclusion and attribution**

**Clarifying founder and affiliation details**

**Planning citation integration**

**Clarifying citation source IDs and URLs**

**Confirming project team and funding details**

**Assessing partner model disclosures**

**Clarifying benchmarking methodology citations**


## Bottom line

ReactBench is a very new, vendor-run React-agent eval, not an independent academic benchmark. Its deterministic React-specific checks are useful, but its public task/solution release and undisclosed lab early-access process limit leaderboard credibility.

### 1. Operator, funding, affiliations

- **Operator:** **Million Software, Inc.** ReactBench calls itself “a product of Million Inc.” [GitHub](https://github.com/millionco/reactbench). Founder publicly identified as **Aiden Bai**; the company is YC W24. (quote: YC describes Million as “Tools for agent verification” and identifies Aiden as founder.)
- ReactBench’s public contributors include **Nisarg Patel** and **Ray Arayilakath** in the repo history, but there is no complete benchmark-team roster or governance policy.
- **Funding:** Million’s own site lists YC plus backers including **Scott Wu, Amjad Masad, Evan You, David Cramer, and “+10 more.”** Amjad Masad is Replit’s founder, so there is an investor-level coding-tool connection. No primary source I found discloses round size, valuation, or funding from OpenAI, Anthropic, xAI, Google, Moonshot, etc.
- **Provider affiliation:** no formal model-lab partnership disclosed. But OpenAI co-founder Greg Brockman amplified the launch-day claim that “Sol” was 6x more price-efficient. [X](https://x.com/gdb/status/2077470575249994010) This is promotion, not evidence of a commercial partnership.

### 2. Methodology

- **51-task v1 panel** across 50+ open-source React repos. Two task types:
  - **Write React:** reproduce a real feature/fix derived from a merged PR.
  - **Fix React:** remove selected React Doctor findings while retaining behavior.
- Grading is deterministic: hidden behavior tests, often browser/Playwright tests, plus a pinned subset of **React Doctor** rules. No LLM judge. (quote: “ReactBench does not use … an LLM-as-a-judge” and says it pins the scanner version and baseline.)
- Reported score: average **Pass@1 across five trials**. (quote: “We report the average of the pass@1 across 5 trials.”)
- Humans review trajectories/patches and classify suspected benchmark failures, but no public inter-rater agreement, reviewer identities, or full adjudication log.
- **Public vs private:** tests and reference patches are hidden from the agent *during a run*, but the GitHub repository publicly exposes task folders, verifier files, and solutions, including [`src.patch`](https://github.com/millionco/reactbench/tree/main/tasks/docusaurus-tabs-11733/solution). It is therefore **not a durable private test set after release**.
- **Contamination:** claimed mitigations are PR recency, small-repo criteria, a canary string, and versioning. This reduces pre-release exposure, not post-release training exposure. No stated refresh cadence. Two tasks were added to the public repo on July 16, one day after launch.
- Documentation says task source commits, manifests and artifacts will be versioned; it does not state a fixed refresh schedule.

### 3. SWE-Bench use

- **No evidence it uses SWE-Bench, SWE-Bench Verified, or another SWE-Bench derivative.**
- Its public repo has no SWE-Bench references and declares only `harbor` as its runtime dependency. Tasks are described as its own React PR-derived work. (quote: The repository describes its own Write React and Fix React tasks and identifies Harbor as the framework.)
- Caveat: that establishes no public code/task provenance link, not a guarantee about unpublished internal workflows.

### 4. Current leaderboard, checked July 17

Top **configurations**, not ten distinct model families, on the [live leaderboard](https://www.reactbench.com/data):

| Rank | Configuration | Pass@1 |
|---:|---|---:|
| 1 | GPT-5.6 Sol, Medium | 43.1% |
| 2 | GPT-5.6 Sol, XHigh | 43.1% |
| 3 | GPT-5.6 Sol, Low | 42.7% |
| 4 | GPT-5.6 Sol, Max | 42.4% |
| 5 | Fable 5, XHigh | 41.2% |
| 6 | GPT-5.6 Sol, High | 40.4% |
| 7 | Fable 5, Max | 40.0% |
| 8 | GPT-5.6 Terra, Medium | 38.0% |
| 9 | Fable 5, Low | 37.3% |
| 10 | GPT-5.6 Terra, XHigh | 36.9% |

Score caveats:

- They evaluate **agents plus harnesses and effort settings**, not base models in isolation. ReactBench acknowledges harness differences can matter.
- Five trials over a 51-task panel is limited; no confidence intervals are shown. The authors themselves say the leaders are too close to call a clear winner.
- The score is partly a measure of compliance with Million’s own React Doctor rule subset.
- Public solutions/tests create an immediate contamination issue for future runs, especially where labs may receive early access.

### 5. Independence red flags

- **Direct financial/product alignment:** Million owns React Doctor and uses a curated React Doctor subset as the benchmark’s non-behavioral gate.
- **Early-access option:** it explicitly invites model labs/coding-agent teams to get early access to held-out tasks or “collaborate.” No disclosure framework says which labs received access or under what embargo. (quote: The benchmark invites labs and agent teams to “get early access to new benchmarks, or collaborate.”)
- **Launch-day OpenAI amplification:** Brockman’s post is material promotional context, but I found no announced launch partnership.
- **Investor connection:** Amjad Masad/Replit is a listed backer. That is not evidence Replit influenced results.
- **No evidence found** of sponsorship disclosures, paid leaderboard placement, affiliate links to providers, or formal “partner model” badges in the site, blog, or public repo.

### 6. Independent X discussion

Very little substantive independent commentary exists yet.

- **Alex Shaw**, Terminal-Bench/Harbor builder, called ReactBench “a great example” of a targeted benchmark exposing weak React performance, while also warning that a handful of benchmarks cannot capture the full range of real capability. [X](https://x.com/alexgshaw/status/2077439213939949716)
- **Iaiso**, a software engineer, ran one task and reported that every sampled model failed the React Doctor part. That is one task, not a benchmark-wide replication. [X](https://x.com/laiso/status/2078087280670159162)
- The main launch thread included requests for task details and whether the benchmark was public, but I found no independent evidence alleging provider influence, paid placement, or evaluator manipulation.

![Current ReactBench leaderboard](./tmp/reactbench-leaderboard.png)
