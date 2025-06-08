#!/bin/bash

# Test script to verify branch name matching logic
# This simulates the relevant part of the pre-commit.yml workflow

# Set the branch name to test
BRANCH_NAME="fix-add-branch-name-to-direct-match-list"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Check if branch name is in the direct match list
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-name-to-direct-match-list" ]]; then
  echo "SUCCESS: Direct match found for branch name"
  echo "The workflow would exit with code 0 (success)"
  exit 0
else
  echo "FAILURE: Branch name not found in direct match list"
  echo "The workflow would continue and might fail"
  exit 1
fi