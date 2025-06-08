#!/bin/bash

# Set test branch name
BRANCH_NAME="fix-pre-commit-workflow-pattern-matching"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing pattern matching with branch name: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test the old pattern matching (using =~ operator)
echo -e "\nTesting OLD pattern matching with =~ operator:"
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}' using =~ operator"
  if [[ "${BRANCH_NAME_LOWER}" =~ ${kw} ]]; then
    echo "OLD MATCH FOUND: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
  else
    echo "OLD NO MATCH: branch does not contain keyword '${kw}'"
  fi
done

echo -e "\nOld pattern matching result: MATCH_FOUND=${MATCH_FOUND}"

# Reset variables
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test the new pattern matching (using glob pattern matching)
echo -e "\nTesting NEW pattern matching with glob pattern matching:"
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}' using glob pattern matching"
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "NEW MATCH FOUND: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
  else
    echo "NEW NO MATCH: branch does not contain keyword '${kw}'"
  fi
done

echo -e "\nNew pattern matching result: MATCH_FOUND=${MATCH_FOUND}"