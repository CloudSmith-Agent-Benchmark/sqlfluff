#!/bin/bash

# Test script to validate pattern matching fix
BRANCH_NAME="fix-workflow-pattern-matching"
echo "Testing pattern matching with branch name: ${BRANCH_NAME}"

# Test the old pattern matching (should fail)
patterns=("pattern" "regex" "trailing-whitespace" "formatting" "syntax" "conditional")
echo "Testing original pattern matching (without quotes):"
for pattern in "${patterns[@]}"; do
  if [[ "${BRANCH_NAME}" == *${pattern}* ]]; then
    echo "✓ Found match with pattern: ${pattern}"
  else
    echo "✗ No match with pattern: ${pattern}"
  fi
done

echo ""
echo "Testing fixed pattern matching (with quotes):"
for pattern in "${patterns[@]}"; do
  if [[ "${BRANCH_NAME}" == *"${pattern}"* ]]; then
    echo "✓ Found match with pattern: ${pattern}"
  else
    echo "✗ No match with pattern: ${pattern}"
  fi
done