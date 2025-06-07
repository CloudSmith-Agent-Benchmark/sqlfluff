#!/bin/bash

# Test script to validate branch name pattern matching

# Simulate the branch name
BRANCH_NAME="fix-add-newline-keyword-to-workflow"
echo "Testing with branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline")
echo "Checking branch name '${BRANCH_NAME_LOWER}' for keywords..."
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test the original pattern matching approach
echo "Testing original pattern matching approach:"
for kw in "${KEYWORDS[@]}"; do
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "Original approach - Match found: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
    break
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "Original approach - Match found: ${MATCHED_KEYWORD}"
else
  echo "Original approach - No match found"
fi

# Reset for the new approach
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test the new regex pattern matching approach
echo -e "\nTesting new regex pattern matching approach:"
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'..."
  if [[ "${BRANCH_NAME_LOWER}" =~ "${kw}" ]]; then
    echo "New approach - Match found: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
    break
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "New approach - Match found: ${MATCHED_KEYWORD}"
else
  echo "New approach - No match found"
fi

# Reset for the special case check
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test the special case check
echo -e "\nTesting special case check:"
if [[ "${BRANCH_NAME_LOWER}" == *newline* ]]; then
  echo "Special case - Match found: branch contains 'newline'"
  MATCHED_KEYWORD="newline (special case)"
  MATCH_FOUND=true
fi

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "Special case - Match found: ${MATCHED_KEYWORD}"
else
  echo "Special case - No match found"
fi

# Test with normalized branch name
echo -e "\nTesting with normalized branch name:"
NORMALIZED_BRANCH=$(echo "${BRANCH_NAME_LOWER}" | tr -cd 'a-z0-9')
echo "Normalized branch name: ${NORMALIZED_BRANCH}"

MATCH_FOUND=false
MATCHED_KEYWORD=""

for kw in "${KEYWORDS[@]}"; do
  NORMALIZED_KW=$(echo "${kw}" | tr -cd 'a-z0-9')
  echo "Checking if normalized '${NORMALIZED_BRANCH}' contains '${NORMALIZED_KW}'..."
  if [[ "${NORMALIZED_BRANCH}" =~ "${NORMALIZED_KW}" ]]; then
    echo "Normalized approach - Match found: contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw} (normalized)"
    MATCH_FOUND=true
    break
  fi
done

if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "Normalized approach - Match found: ${MATCHED_KEYWORD}"
else
  echo "Normalized approach - No match found"
fi