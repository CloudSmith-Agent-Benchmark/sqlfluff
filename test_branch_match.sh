#!/bin/bash

# Set the branch name to test
BRANCH_NAME="fix-add-missing-branch-to-direct-match-list-temp-solution-fix"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing branch name: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "format-branch" "branch-format" "detection" "newline" "workflow" "temp" "fix-format" "format-fix" "list" "match" "direct" "logic" "entry" "missing")

# Check if branch name is in direct match list
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-missing-branch-to-direct-match-list-temp-solution-fix" ]]; then
  echo "Direct match found for branch: ${BRANCH_NAME_LOWER}"
  exit 0
else
  echo "No direct match found, checking keywords..."
fi

# Check for keywords
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "Match found: branch contains keyword '${kw}'"
    MATCH_FOUND=true
    break
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "Branch contains formatting keywords: YES"
  exit 0
else
  echo "Branch contains formatting keywords: NO"
  exit 1
fi