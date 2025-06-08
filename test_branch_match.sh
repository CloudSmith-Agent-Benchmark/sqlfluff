#!/bin/bash

BRANCH_NAME="fix-direct-match-list-add-timestamp-branch-fix"
echo "Testing branch name: ${BRANCH_NAME}"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

if [[ "${BRANCH_NAME_LOWER}" == "fix-direct-match-list-add-timestamp-branch-fix" ]]; then
  echo "SUCCESS: Direct match found for branch name"
  exit 0
else
  echo "FAILURE: Branch name not matched"
  exit 1
fi
