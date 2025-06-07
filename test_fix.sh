#!/bin/bash

# Test script to verify pattern matching fix

BRANCH_NAME="fix-pattern-matching-bash"
echo "Testing with branch name: ${BRANCH_NAME}"

# Test with original pattern matching
echo "Original pattern matching (without quotes):"
if [[ "${BRANCH_NAME}" == *pattern* ]]; then
  echo "  Match found for 'pattern'"
else
  echo "  No match found for 'pattern'"
fi

# Test with fixed pattern matching
echo "Fixed pattern matching (with quotes):"
if [[ "${BRANCH_NAME}" == *"pattern"* ]]; then
  echo "  Match found for 'pattern'"
else
  echo "  No match found for 'pattern'"
fi

# Test with array iteration like in the workflow
echo "Testing array iteration:"
patterns=("pattern" "regex" "trailing-whitespace" "formatting" "syntax" "conditional")
for pattern in "${patterns[@]}"; do
  echo -n "  Testing pattern '${pattern}': "
  if [[ "${BRANCH_NAME}" == *"${pattern}"* ]]; then
    echo "Match found"
  else
    echo "No match found"
  fi
done