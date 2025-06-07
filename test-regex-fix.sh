#!/bin/bash

# Test script to verify the regex pattern matching fix

# Test branch names
TEST_BRANCHES=(
  "fix-regex-pattern-matching-bash"
  "fix-formatting-issues"
  "feature-new-stuff"
  "fix-trailing-whitespace"
  "fix-branch-detection"
  "fix-grep-command"
)

echo "Testing regex pattern matching with explicit grouping:"
echo "===================================================="

for branch in "${TEST_BRANCHES[@]}"; do
  echo -n "Testing branch '$branch': "
  
  # Convert to lowercase
  branch_lower=$(echo "$branch" | tr '[:upper:]' '[:lower:]')
  
  # Test with the fixed pattern (with parentheses)
  if [[ ${branch_lower} =~ (.*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.*) ]]; then
    echo "MATCH FOUND: ${BASH_REMATCH[0]}"
  else
    echo "NO MATCH"
  fi
done

echo -e "\nTesting regex pattern matching without grouping (original):"
echo "===================================================="

for branch in "${TEST_BRANCHES[@]}"; do
  echo -n "Testing branch '$branch': "
  
  # Convert to lowercase
  branch_lower=$(echo "$branch" | tr '[:upper:]' '[:lower:]')
  
  # Test with the original pattern (without parentheses)
  if [[ ${branch_lower} =~ .*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.* ]]; then
    echo "MATCH FOUND: ${BASH_REMATCH[0]}"
  else
    echo "NO MATCH"
  fi
done