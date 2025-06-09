#!/bin/bash

# Test script to validate the pattern matching fix

# Test cases
test_branches=(
  "fix-grep-quotes-in-workflow-temp"
  "fix-formatting-issues"
  "fix-pattern-matching"
  "fix-trailing-whitespace"
  "fix-something-else"
  "feature-new-stuff"
)

echo "Testing pattern matching for branch names:"
echo "----------------------------------------"

for branch in "${test_branches[@]}"; do
  echo -e "\nTesting branch: $branch"
  
  # Check if branch starts with fix-
  if [[ $branch =~ ^fix- ]]; then
    echo "Branch starts with 'fix-': YES"
    
    # Test the old pattern (with -E flag and double quotes)
    echo "Old pattern match (-iE with double quotes):"
    if echo "$branch" | grep -iE "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)" > /dev/null; then
      echo "  Match found: YES"
      echo "  $branch" | grep -iE --color=always "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)"
    else
      echo "  Match found: NO"
    fi
    
    # Test the new pattern (with -i flag and single quotes)
    echo "New pattern match (-i with single quotes):"
    if echo "$branch" | grep -i 'pattern\|regex\|grep\|trailing-whitespace\|formatting\|branch-detection' > /dev/null; then
      echo "  Match found: YES"
      echo "  $branch" | grep -i --color=always 'pattern\|regex\|grep\|trailing-whitespace\|formatting\|branch-detection'
    else
      echo "  Match found: NO"
    fi
  else
    echo "Branch starts with 'fix-': NO"
  fi
done