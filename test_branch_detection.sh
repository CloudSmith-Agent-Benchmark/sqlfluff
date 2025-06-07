#!/bin/bash

# Test script to validate branch detection logic

# Test cases
test_branches=(
  "fix-branch-detection-improvement"
  "fix-formatting-issues"
  "fix-regex-pattern"
  "feature-new-functionality"
  "main"
  "develop"
)

echo "Testing branch detection logic..."
echo "=================================="
echo

for branch in "${test_branches[@]}"; do
  echo "Testing branch: $branch"
  
  # Apply the same logic as in the workflow
  if [[ -n "${branch}" ]] && [[ ${branch} =~ ^fix- ]] && (echo "${branch}" | grep -q -E "pattern|regex|trailing-whitespace|formatting|branch-detection|quotes|match"); then
    echo "  RESULT: MATCH - This branch would be recognized as a formatting fix branch"
  else
    echo "  RESULT: NO MATCH - This branch would NOT be recognized as a formatting fix branch"
  fi
  echo
done

echo "Test completed."