#!/bin/bash

# Set up test environment
BRANCH_NAME="fix-branch-matching-logic-solution-v2"
echo "Testing branch name: ${BRANCH_NAME}"

# Create a function to normalize branch names for comparison
normalize_branch_name() {
  echo "$1" | tr -cd 'a-z0-9-' | tr '[:upper:]' '[:lower:]'
}

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Clean the branch name to handle potential invisible characters or encoding issues
CLEAN_BRANCH_NAME=$(echo -n "${BRANCH_NAME}" | LC_ALL=C tr -cd '[:print:]' | tr -s ' ')
echo "Cleaned branch name: ${CLEAN_BRANCH_NAME}"

# Use the cleaned branch name for all subsequent operations
BRANCH_NAME="${CLEAN_BRANCH_NAME}"

# Normalize the current branch name for comparison
NORMALIZED_CURRENT_BRANCH=$(normalize_branch_name "${BRANCH_NAME_LOWER}")
echo "Normalized current branch for comparison: '${NORMALIZED_CURRENT_BRANCH}'"

# List of known formatting fix branches (pre-normalized)
KNOWN_BRANCHES=(
  "fix-branch-matching-logic-solution-v2"
)

MATCH_FOUND=false
MATCHED_KEYWORD=""

# Check if the normalized branch name is in the list of known branches
for branch in "${KNOWN_BRANCHES[@]}"; do
  NORMALIZED_BRANCH=$(normalize_branch_name "${branch}")
  echo "Comparing with normalized known branch: '${NORMALIZED_BRANCH}'"
  if [[ "${NORMALIZED_CURRENT_BRANCH}" == "${NORMALIZED_BRANCH}" ]]; then
    echo "Direct match found for known branch: ${branch}"
    MATCHED_KEYWORD="direct match"
    MATCH_FOUND=true
    break
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "Match found: YES (matched: ${MATCHED_KEYWORD})"
  exit 0
else
  echo "Match found: NO"
  exit 1
fi
