#!/bin/bash

# Set test branch name
BRANCH_NAME="fix-pre-commit-workflow-pattern-matching"
echo "Testing with branch name: ${BRANCH_NAME}"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  # Convert branch name to lowercase for case-insensitive matching
  BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
  echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

  # Define keywords to look for
  KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")
  echo "Checking branch name '${BRANCH_NAME_LOWER}' for keywords..."
  MATCH_FOUND=false
  MATCHED_KEYWORD=""

  # First test the old method
  echo -e "\n--- TESTING OLD METHOD (=~ operator) ---"
  for kw in "${KEYWORDS[@]}"; do
    echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}' using =~ operator"
    if [[ "${BRANCH_NAME_LOWER}" =~ ${kw} ]]; then
      echo "OLD MATCH FOUND: branch contains keyword '${kw}'"
      MATCHED_KEYWORD="${kw}"
      MATCH_FOUND=true
      break
    fi
  done
  
  echo "Old method result: MATCH_FOUND=${MATCH_FOUND}, MATCHED_KEYWORD=${MATCHED_KEYWORD}"
  
  # Reset variables
  MATCH_FOUND=false
  MATCHED_KEYWORD=""
  
  # Now test the new method
  echo -e "\n--- TESTING NEW METHOD (glob pattern matching) ---"
  for kw in "${KEYWORDS[@]}"; do
    echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}' using glob pattern matching"
    if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
      echo "NEW MATCH FOUND: branch contains keyword '${kw}'"
      MATCHED_KEYWORD="${kw}"
      MATCH_FOUND=true
      break
    fi
  done
  
  echo "New method result: MATCH_FOUND=${MATCH_FOUND}, MATCHED_KEYWORD=${MATCHED_KEYWORD}"
  
  # Test with a different branch name that should not match
  echo -e "\n--- TESTING WITH NON-MATCHING BRANCH ---"
  NON_MATCH_BRANCH="fix-something-else"
  NON_MATCH_BRANCH_LOWER=$(echo "${NON_MATCH_BRANCH}" | tr '[:upper:]' '[:lower:]')
  echo "Non-matching branch: ${NON_MATCH_BRANCH_LOWER}"
  
  MATCH_FOUND=false
  for kw in "${KEYWORDS[@]}"; do
    if [[ "${NON_MATCH_BRANCH_LOWER}" == *"${kw}"* ]]; then
      echo "MATCH FOUND in non-matching branch: contains keyword '${kw}'"
      MATCH_FOUND=true
      break
    fi
  done
  
  if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "No match found in non-matching branch - CORRECT!"
  fi
else
  echo "Branch starts with 'fix-': NO"
fi