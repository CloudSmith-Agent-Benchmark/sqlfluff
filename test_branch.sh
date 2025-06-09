#!/bin/bash
BRANCH_NAME="fix-add-branch-to-direct-match-list-1749425016-fix-solution-temp-fix"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-1749425016-fix-solution-temp-fix" ]]; then
  echo "Branch name matched successfully!"
  exit 0
else
  echo "Branch name did not match."
  exit 1
fi
