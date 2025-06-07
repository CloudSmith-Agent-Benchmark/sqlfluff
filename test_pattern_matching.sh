#!/bin/bash

# Test branch name
BRANCH_NAME="fix-pattern-matching-bash"
echo "Testing with branch name: ${BRANCH_NAME}"

# Test direct pattern matching
echo "Direct test - Contains 'pattern': $([[ "${BRANCH_NAME}" == *"pattern"* ]] && echo "true" || echo "false")"

# Test the loop from the workflow
echo "Testing loop from workflow:"
patterns=("pattern" "regex" "trailing-whitespace" "formatting" "syntax" "conditional")
for pattern in "${patterns[@]}"; do
  if [[ "${BRANCH_NAME}" == *"${pattern}"* ]]; then
    echo "Found match with pattern: ${pattern}"
  else
    echo "No match with pattern: ${pattern}"
  fi
done