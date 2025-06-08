#!/bin/bash

# Set up test environment
GITHUB_REF="refs/heads/fix-direct-match-list-update-solution-1749367235"
GITHUB_HEAD_REF=""
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
GITHUB_OUTPUT="/tmp/github_output_test.txt"

echo "Testing branch name: $BRANCH_NAME"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: '${BRANCH_NAME_LOWER}'"

# Check if branch is in direct match list
if [[ "${BRANCH_NAME_LOWER}" == "fix-direct-match-list-update-solution-1749367235" ]]; then
  echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
  echo "is_formatting_fix=true" >> $GITHUB_OUTPUT
  echo "TEST PASSED: Branch correctly identified as formatting fix branch"
  exit 0
else
  echo "Direct match NOT found for branch: ${BRANCH_NAME_LOWER}"
  echo "TEST FAILED: Branch should have been identified as formatting fix branch"
  exit 1
fi
