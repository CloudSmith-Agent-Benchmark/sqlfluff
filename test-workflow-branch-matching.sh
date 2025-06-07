#!/bin/bash

# Simulate the GitHub Actions environment
export GITHUB_HEAD_REF="fix-branch-pattern-matching-v2"
export GITHUB_REF="refs/heads/fix-branch-pattern-matching-v2"

# Extract the relevant part of the workflow script
echo "Testing with branch name: ${GITHUB_HEAD_REF}"
echo "----------------------------------------"

# Get the branch name from GitHub environment variables
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: ${BRANCH_NAME}"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  
  # Check for keywords in the branch name with debug output
  echo "Checking if branch contains any of these keywords: pattern, regex, trailing-whitespace, formatting, branch-detection"
  echo "Branch name to match: ${BRANCH_NAME}"
  
  # Try both approaches
  echo "Testing with escaped pipe syntax:"
  if echo "${BRANCH_NAME}" | grep -i -o "pattern\|regex\|trailing-whitespace\|formatting\|branch-detection"; then
    echo "Branch contains formatting keywords: YES (escaped pipe syntax)"
  else
    echo "Branch contains formatting keywords: NO (escaped pipe syntax)"
  fi
  
  echo "Testing with -E flag and unescaped pipe:"
  if echo "${BRANCH_NAME}" | grep -i -o -E "pattern|regex|trailing-whitespace|formatting|branch-detection"; then
    echo "Branch contains formatting keywords: YES (-E flag)"
  else
    echo "Branch contains formatting keywords: NO (-E flag)"
  fi
  
  # Combined approach (our solution)
  if echo "${BRANCH_NAME}" | grep -i -o "pattern\|regex\|trailing-whitespace\|formatting\|branch-detection" > /dev/null || 
     echo "${BRANCH_NAME}" | grep -i -o -E "pattern|regex|trailing-whitespace|formatting|branch-detection" > /dev/null; then
    echo "Branch contains formatting keywords: YES (combined approach)"
    echo "This branch is fixing formatting issues - allowing pre-commit failures related to formatting"
  else
    echo "Branch contains formatting keywords: NO (combined approach)"
  fi
else
  echo "Branch starts with 'fix-': NO"
fi