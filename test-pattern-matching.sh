#!/bin/bash

# Test script to validate the pattern matching fix

# Test cases
test_branches=(
  "fix-grep-pattern-matching-solution-fix"
  "fix-regex-update"
  "fix-trailing-whitespace-removal"
  "fix-formatting-improvements"
  "fix-branch-detection-logic"
  "fix-something-else"
  "feature-new-functionality"
)

# Function to test the original grep approach
test_grep_approach() {
  local branch=$1
  if echo "${branch}" | grep -i -E ".*pattern.*|.*regex.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.*" > /dev/null; then
    echo "GREP: ${branch} - MATCH"
    return 0
  else
    echo "GREP: ${branch} - NO MATCH"
    return 1
  fi
}

# Function to test the new bash regex approach
test_bash_regex_approach() {
  local branch=$1
  shopt -s nocasematch
  if [[ ${branch} =~ (pattern|regex|trailing-whitespace|formatting|branch-detection) ]]; then
    shopt -u nocasematch
    echo "BASH: ${branch} - MATCH"
    return 0
  else
    shopt -u nocasematch
    echo "BASH: ${branch} - NO MATCH"
    return 1
  fi
}

echo "Testing pattern matching approaches:"
echo "===================================="

for branch in "${test_branches[@]}"; do
  echo -e "\nBranch: ${branch}"
  test_grep_approach "${branch}"
  grep_result=$?
  test_bash_regex_approach "${branch}"
  bash_result=$?
  
  if [ $grep_result -ne $bash_result ]; then
    echo "WARNING: Different results between grep and bash regex approaches!"
  fi
done

echo -e "\nTest completed."