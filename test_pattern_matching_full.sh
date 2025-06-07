#!/bin/bash

# More comprehensive test script to validate pattern matching fix
BRANCH_NAME="fix-workflow-pattern-matching"
echo "Testing pattern matching with branch name: ${BRANCH_NAME}"

# Test with debug output similar to the workflow
echo "Debug: Starts with fix-: $([[ "${BRANCH_NAME}" =~ ^fix- ]] && echo "true" || echo "false")"
echo "Debug: Contains pattern: $([[ "${BRANCH_NAME}" == *"pattern"* ]] && echo "true" || echo "false")"

# Simulate the actual workflow logic
if [[ "${BRANCH_NAME}" =~ ^fix- ]]; then
  echo "Branch starts with fix-"
  patterns=("pattern" "regex" "trailing-whitespace" "formatting" "syntax" "conditional")
  
  echo "Testing original pattern matching (without quotes):"
  for pattern in "${patterns[@]}"; do
    echo -n "Checking pattern '${pattern}': "
    if [[ "${BRANCH_NAME}" == *${pattern}* ]]; then
      echo "✓ Match found"
    else
      echo "✗ No match"
    fi
  done
  
  echo ""
  echo "Testing fixed pattern matching (with quotes):"
  for pattern in "${patterns[@]}"; do
    echo -n "Checking pattern '${pattern}': "
    if [[ "${BRANCH_NAME}" == *"${pattern}"* ]]; then
      echo "✓ Match found"
    else
      echo "✗ No match"
    fi
  done
  
  # Test with explicit pattern
  echo ""
  echo "Testing with explicit pattern 'pattern':"
  pattern="pattern"
  echo -n "Without quotes: "
  if [[ "${BRANCH_NAME}" == *${pattern}* ]]; then
    echo "✓ Match found"
  else
    echo "✗ No match"
  fi
  
  echo -n "With quotes: "
  if [[ "${BRANCH_NAME}" == *"${pattern}"* ]]; then
    echo "✓ Match found"
  else
    echo "✗ No match"
  fi
fi