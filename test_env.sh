#!/bin/bash

# Create a mock environment to simulate GitHub Actions
export GITHUB_REF="refs/heads/​fix-conditional-logic"  # Note: This has a zero-width space before "fix-"
export GITHUB_HEAD_REF=""

# Get the branch name from GitHub environment variables
# For pull requests, GITHUB_HEAD_REF contains the source branch name
# For direct pushes, we extract it from GITHUB_REF
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: '${BRANCH_NAME}'"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ "${BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
  SKIP_FAILURE_CHECKS=true
else
  echo "Branch starts with 'fix-': NO"
  SKIP_FAILURE_CHECKS=false
fi

echo "SKIP_FAILURE_CHECKS=${SKIP_FAILURE_CHECKS}"

# Try to fix the issue by trimming any invisible characters
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | sed 's/^[[:space:]]*//')
echo "Clean branch name: '${CLEAN_BRANCH_NAME}'"

if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Clean branch starts with 'fix-': YES"
else
  echo "Clean branch starts with 'fix-': NO"
fi

# Try another approach with tr to remove non-printable characters
FILTERED_BRANCH_NAME=$(echo "${BRANCH_NAME}" | tr -d '[:cntrl:]' | tr -d '[:space:]')
echo "Filtered branch name: '${FILTERED_BRANCH_NAME}'"

if [[ "${FILTERED_BRANCH_NAME}" == fix-* ]]; then
  echo "Filtered branch starts with 'fix-': YES"
else
  echo "Filtered branch starts with 'fix-': NO"
fi
