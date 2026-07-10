# Trial: <model> — <date>

- **Checklist item**: intelligence (bulk task) | taste (user-facing task) | sentiment recheck
- **Task**: what was actually asked, and the repo/context it came from (real work, not synthetic)
- **Command**: `subagent <model> ...`
- **Incumbent compared against** (if any): model + same-task output
- **Outcome**: pass | fail
- **Evidence**: verifiable result (tests passing, diff quality, blind-compare winner), links/paths
- **Notes**: steering effort needed, surprises, cost/quota observations

<!-- One file per trial: trials/YYYY-MM-DD-<model>-<int|taste|sentiment>.md -->
