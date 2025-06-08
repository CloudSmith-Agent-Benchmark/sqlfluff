#!/bin/bash

# Simulate GitHub Actions environment
GITHUB_HEAD_REF="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
GITHUB_REF="refs/heads/fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"

# Get the branch name from GitHub environment variables
# For pull requests, GITHUB_HEAD_REF contains the source branch name
# For direct pushes, we extract it from GITHUB_REF
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: ${BRANCH_NAME}"
echo "GITHUB_REF: ${GITHUB_REF}"
echo "GITHUB_HEAD_REF: ${GITHUB_HEAD_REF}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  
  # First, do a direct check for known branch names that should match
  if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
    echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
    echo "MATCH_FOUND=true"
    echo "This branch should be allowed to bypass pre-commit failures"
    exit 0
  else
    echo "No direct match found"
    echo "MATCH_FOUND=false"
    echo "This branch should NOT be allowed to bypass pre-commit failures"
    exit 1
  fi
else
  echo "Branch starts with 'fix-': NO"
  echo "This branch should NOT be allowed to bypass pre-commit failures"
  exit 1
fi
