#!/bin/bash

# Set the branch name to test
BRANCH_NAME="fix-add-branch-to-direct-match-list-solution-temp"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Clean branch name for comparison
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME_LOWER}" | tr -d '[:space:]')
echo "Clean branch name: ${CLEAN_BRANCH_NAME}"

# Create an array with a subset of the branches from the workflow file
DIRECT_MATCH_BRANCHES=(
  "fix-regex-pattern-matching-cloudsmith"
  "fix-pattern-matching-workflow-v2"
  "fix-add-branch-to-direct-match-list"
  "fix-add-branch-to-direct-match-list-temp"
  "fix-add-branch-to-direct-match-list-solution-temp"
  "fix-add-branch-to-direct-match-list-solution-temp-fix"
)

# Debug output
echo "Direct match branches:"
for branch in "${DIRECT_MATCH_BRANCHES[@]}"; do
  echo "  - '${branch}'"
done

# First, do a direct check for known branch names that should match
DIRECT_MATCH=false
for branch in "${DIRECT_MATCH_BRANCHES[@]}"; do
  # Use a more robust comparison by removing all whitespace from both strings
  CLEAN_BRANCH=$(echo "${branch}" | tr -d '[:space:]')
  echo "Comparing '${CLEAN_BRANCH_NAME}' with cleaned '${CLEAN_BRANCH}'"
  if [[ "${CLEAN_BRANCH_NAME}" == "${CLEAN_BRANCH}" ]]; then
    echo "Direct match found: '${branch}'"
    DIRECT_MATCH=true
    break
  fi
done

if [[ "$DIRECT_MATCH" == "true" ]]; then
  echo "RESULT: Direct match found for branch: ${BRANCH_NAME}"
  exit 0
else
  echo "RESULT: No direct match found for branch: ${BRANCH_NAME}"
  exit 1
fi
