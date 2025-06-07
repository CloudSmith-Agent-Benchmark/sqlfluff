#!/bin/bash

# Test with a branch name that has an invisible zero-width space at the beginning
# We use echo -n -e to ensure the zero-width space is properly included
BRANCH_NAME=$(echo -n -e "\u200bfix-conditional-logic")

echo "Original branch name (with zero-width space): ${BRANCH_NAME}"

# Original approach - should fail
if [[ "${BRANCH_NAME}" == fix-* ]]; then
  echo "Original condition - Branch starts with 'fix-': YES"
else
  echo "Original condition - Branch starts with 'fix-': NO"
fi

# Our solution - should work
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | LC_ALL=C tr -dc "[:graph:][:space:]")
echo "Clean branch name: '${CLEAN_BRANCH_NAME}'"

if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Fixed condition - Branch starts with 'fix-': YES"
  SKIP_FAILURE_CHECKS=true
else
  echo "Fixed condition - Branch starts with 'fix-': NO"
  SKIP_FAILURE_CHECKS=false
fi

echo "SKIP_FAILURE_CHECKS=${SKIP_FAILURE_CHECKS}"
