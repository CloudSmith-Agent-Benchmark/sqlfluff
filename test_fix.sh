#!/bin/bash

# Set up test environment
BRANCH_NAME="fix-grep-pattern-matching"
echo "Testing with branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Debug output to show what we're matching against
echo "Testing bash regex pattern match (case-insensitive):"
if [[ ${BRANCH_NAME_LOWER} =~ (pattern|regex|grep|trailing-whitespace|formatting|branch-detection) ]]; then
  echo "Match found: ${BASH_REMATCH[0]}"
else
  echo "No match found"
fi

echo "Test completed successfully!"