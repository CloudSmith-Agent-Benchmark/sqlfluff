#!/bin/bash

# Simple script to verify that the branch name is in the direct match list
# This script extracts the direct match list from the pre-commit.yml workflow file
# and checks if the specified branch name is in the list

BRANCH_NAME="fix-add-direct-match-entry-for-missing-branch"
WORKFLOW_FILE=".github/workflows/pre-commit.yml"

echo "Checking if branch '$BRANCH_NAME' is in the direct match list in $WORKFLOW_FILE..."

# Extract the direct match list from the workflow file
if grep -q "\"${BRANCH_NAME}\"" "$WORKFLOW_FILE"; then
  echo "SUCCESS: Branch '$BRANCH_NAME' is in the direct match list!"
  exit 0
else
  echo "ERROR: Branch '$BRANCH_NAME' is NOT in the direct match list!"
  exit 1
fi