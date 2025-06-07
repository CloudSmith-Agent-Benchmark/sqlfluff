#!/bin/bash

# Test script to verify the regex pattern matching

# Test branch name
BRANCH_NAME="fix-regex-pattern-matching"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Test the old regex pattern
echo "Testing old pattern: pattern|regex|grep|trailing-whitespace|formatting|branch-detection"
if [[ ${BRANCH_NAME_LOWER} =~ pattern|regex|grep|trailing-whitespace|formatting|branch-detection ]]; then
  echo "OLD PATTERN: Match found: ${BASH_REMATCH[0]}"
else
  echo "OLD PATTERN: No match found"
fi

# Test the new regex pattern
echo "Testing new pattern: .*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.*"
if [[ ${BRANCH_NAME_LOWER} =~ .*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.* ]]; then
  echo "NEW PATTERN: Match found: ${BASH_REMATCH[0]}"
else
  echo "NEW PATTERN: No match found"
fi