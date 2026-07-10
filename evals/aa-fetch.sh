#!/usr/bin/env bash
# aa-fetch.sh — pull coding-focused model stats from the Artificial Analysis API
# to inform the rankings in skills/subagent/SKILL.md.
#
#   AA_API_KEY=... ./aa-fetch.sh [-n N] [name-filter]
#
#   ./aa-fetch.sh                 # top 30 by coding index
#   ./aa-fetch.sh -n 60           # top 60
#   ./aa-fetch.sh claude          # only models matching "claude"
#   ./aa-fetch.sh -n 999 ""       # everything with a coding index
#
# Columns (all 0-100 unless noted):
#   code-idx   AA Coding Index (composite)
#   term2.1    Terminal-Bench 2.1  — agentic coding in a real terminal
#   term-hard  Terminal-Bench Hard — agentic coding, hard subset
#   tau2       tau²-bench          — agentic tool use
#   lcb        LiveCodeBench       — competitive coding
#   sci        SciCode             — scientific code generation
#   if         IFBench             — instruction following
#   lcr        Long Context Reasoning
#   intel      AA Intelligence Index (overall)
#
# Free API key: https://artificialanalysis.ai/api  (attribution required, see README)
# Requires: curl, jq

set -euo pipefail

[[ -n "${AA_API_KEY:-}" ]] || { echo "error: set AA_API_KEY (free key: https://artificialanalysis.ai/api)" >&2; exit 1; }
command -v jq >/dev/null || { echo "error: jq is required" >&2; exit 1; }

top=30
if [[ "${1:-}" == "-n" ]]; then top="$2"; shift 2; fi
filter="${1:-}"

curl -fsSL -H "x-api-key: $AA_API_KEY" "https://artificialanalysis.ai/api/v2/data/llms/models" |
jq -r --arg f "$filter" --argjson n "$top" '
  def pct: if . == null then "-" else (. * 100 | round) end;   # 0-1 floats -> 0-100
  def idx: if . == null then "-" else (. + 0.5 | floor) end;   # indices are already 0-100
  .data
  | map(select(((.name // .id // "") | test($f; "i"))
               and (.evaluations.artificial_analysis_coding_index != null)))
  | sort_by(-(.evaluations.artificial_analysis_coding_index // 0))
  | .[:$n]
  | (["model", "creator", "code-idx", "term2.1", "term-hard", "tau2", "lcb", "sci", "if", "lcr", "intel", "$/1M in", "$/1M out", "tok/s"] | @tsv),
    (.[] | [
      (.name // .id),
      (.model_creator.name // "-"),
      (.evaluations.artificial_analysis_coding_index | idx),
      (.evaluations.terminalbench_v2_1 | pct),
      (.evaluations.terminalbench_hard | pct),
      (.evaluations.tau2 | pct),
      (.evaluations.livecodebench | pct),
      (.evaluations.scicode | pct),
      (.evaluations.ifbench | pct),
      (.evaluations.lcr | pct),
      (.evaluations.artificial_analysis_intelligence_index | idx),
      (.pricing.price_1m_input_tokens // "-"),
      (.pricing.price_1m_output_tokens // "-"),
      (.median_output_tokens_per_second // 0 | round)
    ] | @tsv)
' | column -t -s "$(printf '\t')"

echo
echo "Source: Artificial Analysis <https://artificialanalysis.ai> (independent LLM benchmarks)."
