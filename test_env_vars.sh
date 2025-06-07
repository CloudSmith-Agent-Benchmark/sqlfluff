#!/bin/bash

# Simulate the GitHub environment variables
export GITHUB_REF="refs/heads/​fix-invisible-chars"  # With zero-width space
export GITHUB_HEAD_REF=""

# Extract the branch name as done in the workflow
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Extracted branch name: '$BRANCH_NAME'"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Clean the branch name
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | LC_ALL=C tr -dc "[:graph:][:space:]")
echo "Clean branch name: '$CLEAN_BRANCH_NAME'"

# Test the condition
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
else
  echo "Branch starts with 'fix-': NO"
fi

# Hexdump of the branch name
echo "Hexdump of branch name:"
echo -n "${BRANCH_NAME}" | hexdump -C

# Hexdump of the clean branch name
echo "Hexdump of clean branch name:"
echo -n "${CLEAN_BRANCH_NAME}" | hexdump -C
