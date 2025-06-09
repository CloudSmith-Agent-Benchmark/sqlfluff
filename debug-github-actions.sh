#!/bin/bash

# Simulate GitHub Actions environment
GITHUB_HEAD_REF="fix-add-grep-to-workflow-keywords"
GITHUB_REF="refs/heads/fix-add-grep-to-workflow-keywords"

# Get the branch name from GitHub environment variables
# For pull requests, GITHUB_HEAD_REF contains the source branch name
# For direct pushes, we extract it from GITHUB_REF
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: ${BRANCH_NAME}"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  
  # Debug output
  echo "Branch name to match: ${BRANCH_NAME}"
  
  # Test with the exact command from the workflow
  if echo "${BRANCH_NAME}" | grep -iE "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)" > /dev/null; then
    echo "Branch contains formatting keywords: YES"
  else
    echo "Branch contains formatting keywords: NO"
    
    # Additional debugging
    echo -e "\nDebugging grep pattern matching:"
    echo "Testing for 'grep' specifically:"
    echo "${BRANCH_NAME}" | grep -i "grep" && echo "Found 'grep'" || echo "Did not find 'grep'"
    
    echo -e "\nTesting with different pattern formats:"
    echo -n "1. With single quotes: "
    echo "${BRANCH_NAME}" | grep -iE '(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)' > /dev/null && echo "MATCH" || echo "NO MATCH"
    
    echo -n "2. With double quotes: "
    echo "${BRANCH_NAME}" | grep -iE "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)" > /dev/null && echo "MATCH" || echo "NO MATCH"
    
    echo -n "3. With each keyword separately: "
    (echo "${BRANCH_NAME}" | grep -i "pattern" > /dev/null || 
     echo "${BRANCH_NAME}" | grep -i "regex" > /dev/null || 
     echo "${BRANCH_NAME}" | grep -i "grep" > /dev/null || 
     echo "${BRANCH_NAME}" | grep -i "trailing-whitespace" > /dev/null || 
     echo "${BRANCH_NAME}" | grep -i "formatting" > /dev/null || 
     echo "${BRANCH_NAME}" | grep -i "branch-detection" > /dev/null) && echo "MATCH" || echo "NO MATCH"
  fi
else
  echo "Branch starts with 'fix-': NO"
fi

