#!/bin/bash

# Test script to verify branch name matching logic

# Set up test branch name
BRANCH_NAME="fix-workflow-branch-matching-improved"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow" "temp" "fix" "list" "match" "direct")

# First test: Direct match list
echo "Testing direct match list..."
if [[ "${BRANCH_NAME_LOWER}" == "fix-workflow-branch-matching-improved" ]]; then
  echo "✅ Direct match found for branch: ${BRANCH_NAME_LOWER}"
else
  echo "❌ Direct match NOT found for branch: ${BRANCH_NAME_LOWER}"
fi

# Second test: Keyword matching
echo -e "\nTesting keyword matching..."
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "✅ Match found: branch contains keyword '${kw}'"
    MATCH_FOUND=true
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo -e "\n✅ Keywords found in branch name"
else
  echo -e "\n❌ No keywords found in branch name"
fi

echo -e "\nTest completed."