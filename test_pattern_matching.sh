#!/bin/bash

# Test script to validate pattern matching changes
BRANCH_NAME="fix-pattern-matching-glob-syntax"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Testing pattern matching for branch: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")

# Test direct branch matching
if [[ "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-cloudsmith" || "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-workflow-v2" || "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-bash-syntax" || "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-glob-syntax" ]]; then
  echo "✅ Direct match found for known branch: ${BRANCH_NAME_LOWER}"
else
  echo "❌ Direct match not found for known branch: ${BRANCH_NAME_LOWER}"
fi

# Test keyword matching
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
  echo "Testing if '${BRANCH_NAME_LOWER}' contains '${kw}'"
  
  # Test with quoted glob pattern
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "✅ Match found with quoted glob pattern: '${kw}'"
    MATCH_FOUND=true
  fi
  
  # Test with grep
  if echo "${BRANCH_NAME_LOWER}" | grep -q "${kw}"; then
    echo "✅ Match found with grep: '${kw}'"
    MATCH_FOUND=true
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "✅ Final result: Match found"
else
  echo "❌ Final result: No match found"
fi