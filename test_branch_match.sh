#!/bin/bash

check_branch_with_timestamp() {
  local branch_name="$1"
  local base_branches=(
    "fix-add-branch-to-direct-match-list"
    "fix-add-branch-to-direct-match-list-temp"
    "fix-add-branch-to-direct-match-list-temp-fix"
    "fix-direct-match-list-update"
  )
  
  for base in "${base_branches[@]}"; do
    if [[ "${branch_name}" =~ ^${base}-[0-9]+$ ]]; then
      echo "Timestamp match found: branch '${branch_name}' matches base '${base}' with timestamp"
      return 0
    fi
  done
  return 1
}

BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-fix-20250608"
if check_branch_with_timestamp "${BRANCH_NAME}"; then
  echo "Function test: Match found"
else
  echo "Function test: No match"
fi
