#!/bin/bash

# Test script to verify branch pattern detection

# Test branches
test_branches=(
  "fix-branch-pattern-matching-v2"
  "fix-regex-issue"
  "fix-formatting-problem"
  "feature-new-stuff"
  "bugfix-trailing-whitespace"
  "fix-branch-detection-issue"
)

# Function to test branch pattern detection
test_branch_pattern() {
  local branch=$1
  echo "Testing branch: $branch"
  
  # Test with single quotes (original issue)
  if [[ $branch =~ ^fix- ]] && (echo "$branch" | grep -q -E 'pattern|regex|trailing-whitespace|formatting|branch-detection'); then
    echo "  ✅ PASS with single quotes"
  else
    echo "  ❌ FAIL with single quotes"
  fi
  
  # Test with double quotes (fixed version)
  if [[ $branch =~ ^fix- ]] && (echo "$branch" | grep -q -E "pattern|regex|trailing-whitespace|formatting|branch-detection"); then
    echo "  ✅ PASS with double quotes"
  else
    echo "  ❌ FAIL with double quotes"
  fi
  
  echo ""
}

# Run tests for each branch
echo "=== Branch Pattern Detection Test ==="
echo ""

for branch in "${test_branches[@]}"; do
  test_branch_pattern "$branch"
done

echo "=== Test Complete ==="