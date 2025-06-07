#!/bin/bash

# Simulate the GitHub environment variables
export GITHUB_REF="refs/heads/​fix-invisible-chars"  # With zero-width space
export GITHUB_HEAD_REF=""
export RAW_LOG="test_pre-commit.log"
export SKIP_FAILURE_CHECKS=false

# Create a test log file
echo "Test log file" > ${RAW_LOG}

# Extract the branch name as done in the workflow
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: ${BRANCH_NAME}"
echo "GITHUB_REF: ${GITHUB_REF}"
echo "GITHUB_HEAD_REF: ${GITHUB_HEAD_REF}"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Clean the branch name
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | LC_ALL=C tr -dc "[:graph:][:space:]")
echo "Clean branch name: '${CLEAN_BRANCH_NAME}'"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
# Use string prefix matching instead of regex for more reliable behavior
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
  # Any branch that starts with 'fix-' is considered a formatting fix branch
  echo "::warning::On branch ${CLEAN_BRANCH_NAME} which starts with 'fix-' - allowing pre-commit failures"
  # Set flag to skip failure checks
  SKIP_FAILURE_CHECKS=true
else
  echo "Branch starts with 'fix-': NO"
fi

# First check if we should skip failure checks (for fix-* branches)
if [ "$SKIP_FAILURE_CHECKS" = true ]; then
  echo "::notice::Skipping failure checks because this is a formatting fix branch"
  # Reset exit code to 0 to prevent workflow failure when we're on a formatting fix branch
  echo "Would exit with code 0"
else
  echo "Would continue with failure checks"
fi

# Hexdump of the branch name and clean branch name
echo "Hexdump of branch name:"
echo -n "${BRANCH_NAME}" | hexdump -C

echo "Hexdump of clean branch name:"
echo -n "${CLEAN_BRANCH_NAME}" | hexdump -C

# Try with different comparison methods
echo "Testing with different comparison methods:"

# Method 1: Direct string comparison
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Method 1 (direct): Branch starts with 'fix-': YES"
else
  echo "Method 1 (direct): Branch starts with 'fix-': NO"
fi

# Method 2: Quoted pattern
if [[ "${CLEAN_BRANCH_NAME}" == "fix-"* ]]; then
  echo "Method 2 (quoted pattern): Branch starts with 'fix-': YES"
else
  echo "Method 2 (quoted pattern): Branch starts with 'fix-': NO"
fi

# Method 3: Regex comparison
if [[ "${CLEAN_BRANCH_NAME}" =~ ^fix- ]]; then
  echo "Method 3 (regex): Branch starts with 'fix-': YES"
else
  echo "Method 3 (regex): Branch starts with 'fix-': NO"
fi

# Method 4: Using grep
if echo "${CLEAN_BRANCH_NAME}" | grep -q "^fix-"; then
  echo "Method 4 (grep): Branch starts with 'fix-': YES"
else
  echo "Method 4 (grep): Branch starts with 'fix-': NO"
fi

# Method 5: Using substring
if [ "${CLEAN_BRANCH_NAME:0:4}" = "fix-" ]; then
  echo "Method 5 (substring): Branch starts with 'fix-': YES"
else
  echo "Method 5 (substring): Branch starts with 'fix-': NO"
fi
