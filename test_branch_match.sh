#!/bin/bash
BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-fix-1749412924-solution-fix-update"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-1749412924-solution-fix-update" ]]; then
  echo "Direct match found for branch: ${BRANCH_NAME_LOWER}"
  exit 0
else
  echo "Branch not found in direct match list: ${BRANCH_NAME_LOWER}"
  exit 1
fi
