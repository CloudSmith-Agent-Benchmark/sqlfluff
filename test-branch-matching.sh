#!/bin/bash

# Test cases
test_branches=(
  "fix-branch-pattern-matching-v2"
  "fix-something-else"
  "fix-regex-improvements"
  "feature-formatting"
  "fix-trailing-whitespace-removal"
)

echo "Testing branch name pattern matching:"
echo "======================================"

for branch in "${test_branches[@]}"; do
  echo -n "Testing branch '$branch': "
  
  # Original approach (with -E flag)
  if echo "$branch" | grep -i -o -E "pattern|regex|trailing-whitespace|formatting|branch-detection" > /dev/null; then
    echo "ORIGINAL: MATCH"
  else
    echo "ORIGINAL: NO MATCH"
  fi
  
  # New approach (without -E flag, using escaped pipe)
  echo -n "                      "
  if echo "$branch" | grep -i -o "pattern\|regex\|trailing-whitespace\|formatting\|branch-detection"; then
    echo "NEW: MATCH"
  else
    echo "NEW: NO MATCH"
  fi
  echo "--------------------------------------"
done