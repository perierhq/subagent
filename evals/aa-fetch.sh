#!/usr/bin/env bash
# aa-fetch.sh — pull model stats from the Artificial Analysis API to inform the rankings
# in skills/subagent/SKILL.md.
#
#   AA_API_KEY=... ./aa-fetch.sh [name-filter]
#
#   ./aa-fetch.sh              # all models, sorted by intelligence index
#   ./aa-fetch.sh claude       # only models matching "claude"
#
# Free API key: https://artificialanalysis.ai/api  (attribution required, see README)
# Requires: curl, jq

set -euo pipefail

[[ -n "${AA_API_KEY:-}" ]] || { echo "error: set AA_API_KEY (free key: https://artificialanalysis.ai/api)" >&2; exit 1; }
command -v jq >/dev/null || { echo "error: jq is required" >&2; exit 1; }

filter="${1:-}"

curl -fsSL -H "x-api-key: $AA_API_KEY" "https://artificialanalysis.ai/api/v2/data/llms/models" |
jq -r --arg f "$filter" '
  .data
  | map(select(((.name // .id // "") | test($f; "i"))))
  | sort_by(-(.evaluations.artificial_analysis_intelligence_index // 0))
  | (["model", "creator", "intel-idx", "$/1M in", "$/1M out", "tok/s"] | @tsv),
    (.[] | [
      (.name // .id),
      (.model_creator.name // "-"),
      (.evaluations.artificial_analysis_intelligence_index // "-"),
      (.pricing.price_1m_input_tokens // "-"),
      (.pricing.price_1m_output_tokens // "-"),
      (.median_output_tokens_per_second // "-")
    ] | @tsv)
' | column -t -s "$(printf '\t')"

echo
echo "Source: Artificial Analysis <https://artificialanalysis.ai> (independent LLM benchmarks)."
