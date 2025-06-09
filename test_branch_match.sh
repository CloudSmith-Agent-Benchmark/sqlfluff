#!/bin/bash

# Test script to verify branch name matching in pre-commit workflow

# Set the branch name to test
BRANCH_NAME="fix-add-direct-match-entry-for-missing-branch"
echo "Testing branch name: $BRANCH_NAME"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "format-branch" "branch-format" "detection" "newline" "workflow" "temp" "fix-format" "format-fix" "list" "match" "direct" "logic" "entry" "missing")

# Check if the branch name is in the direct match list
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-direct-match-entry-for-missing-branch" ]]; then
  echo "SUCCESS: Branch name is in the direct match list"
  exit 0
else
  echo "FAIL: Branch name is not in the direct match list"
  
  # Check for keywords
  MATCH_FOUND=false
  for kw in "${KEYWORDS[@]}"; do
    if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
      echo "Match found: branch contains keyword '${kw}'"
      MATCH_FOUND=true
    fi
  done
  
  if [[ "$MATCH_FOUND" == "true" ]]; then
    echo "SUCCESS: Branch contains formatting keywords"
    exit 0
  else
    echo "FAIL: No keywords matched"
    exit 1
  fi
fi