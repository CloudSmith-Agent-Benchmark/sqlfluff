#!/bin/bash

# Test cases
test_branches=(
  "fix-regex-pattern-matching"
  "fix-formatting-issues"
  "feature-new-stuff"
  "fix-something-else"
  "fix-grep-related-issue"
)

echo "Testing regex pattern matching with original pattern:"
for branch in "${test_branches[@]}"; do
  branch_lower=$(echo "$branch" | tr '[:upper:]' '[:lower:]')
  echo -n "Branch '$branch': "
  if [[ $branch_lower =~ pattern|regex|grep|trailing-whitespace|formatting|branch-detection ]]; then
    echo "MATCH - ${BASH_REMATCH[0]}"
  else
    echo "NO MATCH"
  fi
done

echo -e "\nTesting regex pattern matching with fixed pattern:"
for branch in "${test_branches[@]}"; do
  branch_lower=$(echo "$branch" | tr '[:upper:]' '[:lower:]')
  echo -n "Branch '$branch': "
  if [[ $branch_lower =~ .*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.* ]]; then
    echo "MATCH - ${BASH_REMATCH[0]}"
  else
    echo "NO MATCH"
  fi
done