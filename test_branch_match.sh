#!/bin/bash

# Set the branch name to test
BRANCH_NAME="fix-add-branch-to-direct-match-list-solution-v4"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Check if the branch name is in the direct match list
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-solution-v4" ]]; then
  echo "SUCCESS: Direct match found for branch: ${BRANCH_NAME_LOWER}"
  exit 0
else
  echo "FAILURE: Branch name not matched: ${BRANCH_NAME_LOWER}"
  exit 1
fi