#!/bin/bash

# Set the branch name to test
BRANCH_NAME="fix-add-missing-branch-to-direct-match-list-1749425016-fix"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "format-branch" "branch-format" "detection" "newline" "workflow" "temp" "fix-format" "format-fix" "list" "match" "direct" "logic" "entry" "missing")

# Check if branch starts with fix-
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  
  # First, do a direct check for known branch names
  if [[ "${BRANCH_NAME_LOWER}" == "fix-add-missing-branch-to-direct-match-list-1749425016-fix" ]]; then
    echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
    echo "MATCH_FOUND=true"
    exit 0
  fi
  
  # Check for keywords
  for kw in "${KEYWORDS[@]}"; do
    if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
      echo "Match found: branch contains keyword '${kw}'"
      echo "MATCH_FOUND=true"
      exit 0
    fi
  done
  
  echo "No match found for branch name"
else
  echo "Branch does not start with 'fix-'"
fi

echo "MATCH_FOUND=false"
exit 1
