#!/bin/bash

# Test script to validate the grep-based pattern matching fix

# Set up test branch names
TEST_BRANCHES=(
  "fix-branch-pattern-detection-solution"
  "fix-trailing-whitespace"
  "feature-new-functionality"
  "bugfix-login-issue"
)

# Define keywords to check for
KEYWORDS="pattern regex grep trailing whitespace spaces formatting branch detection"

echo "Testing grep-based pattern matching with different branch names:"
echo "---------------------------------------------------"

for branch in "${TEST_BRANCHES[@]}"; do
  echo -e "\nTesting branch: $branch"
  BRANCH_NAME_LOWER=$(echo "${branch}" | tr '[:upper:]' '[:lower:]')
  
  echo "Using grep approach:"
  MATCH_FOUND=0
  for keyword in $KEYWORDS; do
    if echo "$BRANCH_NAME_LOWER" | grep -q "$keyword"; then
      echo "✓ Match found with keyword: $keyword"
      MATCH_FOUND=1
      break
    fi
  done
  if [ $MATCH_FOUND -eq 1 ]; then
    echo "Result: Branch contains formatting keywords"
  else
    echo "Result: Branch does NOT contain formatting keywords"
  fi
  
  echo "---------------------------------------------------"
done