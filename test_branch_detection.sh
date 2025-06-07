#!/bin/bash
# Test script for branch name detection

# Set test branch name
BRANCH_NAME="fix-branch-detection-simple"
echo "Test branch name: ${BRANCH_NAME}"

# Add hexdump of branch name to detect invisible characters
echo "Branch name hex representation:"
echo -n "${BRANCH_NAME}" | hexdump -C

# Normalize branch name to remove any potential invisible characters
NORMALIZED_BRANCH=$(echo -n "${BRANCH_NAME}" | LC_ALL=C tr -cd 'a-zA-Z0-9-_')
echo "Normalized branch name: ${NORMALIZED_BRANCH}"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ ${NORMALIZED_BRANCH} =~ ^fix- ]] || [[ "${NORMALIZED_BRANCH}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
else
  echo "Branch starts with 'fix-': NO"
fi
