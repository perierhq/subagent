#!/usr/bin/env bash
# run-trial.sh — run one internal eval task against a model and record the result.
#
#   ./run-trial.sh <model> <task-id>          e.g. ./run-trial.sh gpt-5.6-terra v1/int-1
#   ./run-trial.sh --list                     list available tasks
#
# Tasks are an INTERNAL PRIVATE HOLDOUT (not in this repo, so models can't train on them).
# They live in the private sibling repo `subagent-evals`, cloned next to this repo
# (../subagent-evals/tasks), or wherever $SUBAGENT_TASKS_DIR points. Task layout:
#
#   <tasks-dir>/v1/<task-id>/
#     task.md      # the prompt given to the model
#     fixture/     # project the model works in (copied to a temp dir)
#     check.sh     # exit 0 = pass; absent for taste-* tasks (human judged)
#
# Results are written to evals/trials/ (public: task IDs + pass/fail, never task content).

set -euo pipefail

default_tasks_dir() {
  local sibling; sibling="$(cd "$(dirname "$0")/../.." && pwd)/subagent-evals/tasks"
  if [[ -d "$sibling" ]]; then echo "$sibling"; else echo "$HOME/.subagent/eval-tasks"; fi
}
TASKS_DIR="${SUBAGENT_TASKS_DIR:-$(default_tasks_dir)}"
TRIALS_DIR="$(cd "$(dirname "$0")" && pwd)/trials"
THINKING="${SUBAGENT_TRIAL_THINKING:-high}"   # pinned per suite version; record any override

if [[ "${1:-}" == "--list" ]]; then
  find "$TASKS_DIR" -name task.md 2>/dev/null | sed "s|$TASKS_DIR/||; s|/task.md||" | sort
  exit 0
fi

[[ $# -eq 2 ]] || { sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }
model="$1"; task="$2"
task_dir="$TASKS_DIR/$task"
[[ -f "$task_dir/task.md" ]] || { echo "error: no task at $task_dir (set SUBAGENT_TASKS_DIR?)" >&2; exit 1; }

work="$(mktemp -d "/tmp/subagent-trial-XXXXXX")"
[[ -d "$task_dir/fixture" ]] && cp -R "$task_dir/fixture/." "$work/"
cp "$task_dir/task.md" "$work/task.md"

echo "trial: model=$model task=$task work=$work thinking=$THINKING"
start_ts="$(date +%s)"
set +e
( cd "$work" && subagent "$model" --thinking "$THINKING" "@task.md" ) > "$work/.agent-output.log" 2>&1
agent_exit=$?
set -e
duration=$(( $(date +%s) - start_ts ))

result="needs-human-judgment"
if [[ -x "$task_dir/check.sh" ]]; then
  if ( cd "$work" && "$task_dir/check.sh" ) > "$work/.check-output.log" 2>&1; then
    result="pass"
  else
    result="fail"
  fi
fi

suite="${task%%/*}"
stamp="$(date +%Y-%m-%d)"
record="$TRIALS_DIR/$stamp-$model-$(echo "$task" | tr '/' '-').md"
subagent_version="$(subagent --version | awk '{print $2}')"
cat > "$record" <<EOF
# Trial: $model — $task — $stamp

- **Suite**: $suite (internal holdout)
- **Result**: $result
- **Agent exit**: $agent_exit, duration: ${duration}s
- **Pinned args**: --thinking $THINKING, subagent $subagent_version
- **Workdir**: $work (agent log: .agent-output.log$( [[ -f "$work/.check-output.log" ]] && echo ", checker log: .check-output.log" ))
- **Notes**: <!-- human: steering effort, output quality, surprises; for taste tasks record blind-compare verdict -->
EOF

echo "result: $result (${duration}s)  ->  $record"
[[ "$result" == "needs-human-judgment" ]] && echo "taste task: inspect $work and fill in the verdict in $record"
[[ "$result" == "fail" ]] && { echo "checker output:"; tail -20 "$work/.check-output.log"; }
