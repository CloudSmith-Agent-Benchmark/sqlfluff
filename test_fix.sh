#!/bin/bash

# Get the branch name from GitHub environment variables
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: '${BRANCH_NAME}'"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Clean the branch name by removing any invisible characters
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | tr -cd '[:print:]')
echo "Clean branch name: '${CLEAN_BRANCH_NAME}'"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
  SKIP_FAILURE_CHECKS=true
else
  echo "Branch starts with 'fix-': NO"
  SKIP_FAILURE_CHECKS=false
fi

echo "SKIP_FAILURE_CHECKS=${SKIP_FAILURE_CHECKS}"
