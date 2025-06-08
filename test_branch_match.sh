#!/bin/bash

# Set the branch name for testing
BRANCH_NAME="fix-add-branch-to-direct-match-list-update-temp"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Test direct match
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-update-temp" ]]; then
  echo "✅ Direct match successful"
else
  echo "❌ Direct match failed"
fi

# Test keyword matching
KEYWORDS=("temp" "list" "match" "update")
for kw in "${KEYWORDS[@]}"; do
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "✅ Keyword match successful for '${kw}'"
  else
    echo "❌ Keyword match failed for '${kw}'"
  fi
done

echo "Test completed"