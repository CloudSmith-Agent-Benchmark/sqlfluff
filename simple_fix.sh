#!/bin/bash

# Create a simpler test script to demonstrate the fix
export GITHUB_REF="refs/heads/​fix-conditional-logic"  # Note: This has a zero-width space before "fix-"
export GITHUB_HEAD_REF=""

# Get the branch name from GitHub environment variables
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Original branch name: '${BRANCH_NAME}'"

# Test the original condition
if [[ "${BRANCH_NAME}" == fix-* ]]; then
  echo "Original condition - Branch starts with 'fix-': YES"
else
  echo "Original condition - Branch starts with 'fix-': NO"
fi

# Clean the branch name by removing any invisible characters
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | tr -cd '[:print:]')
echo "Clean branch name: '${CLEAN_BRANCH_NAME}'"

# Test the fixed condition
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Fixed condition - Branch starts with 'fix-': YES"
else
  echo "Fixed condition - Branch starts with 'fix-': NO"
fi

echo -e "\n--- Fix explanation ---"
echo "The issue is caused by invisible characters (like zero-width space, ASCII 8203) at the beginning of the branch name."
echo "These characters are not visible in normal text display but affect string comparisons in bash."
echo "The fix uses 'tr -cd [:print:]' to remove non-printable characters from the branch name before comparison."
echo "This ensures that the branch name pattern matching works correctly even if there are invisible characters."
