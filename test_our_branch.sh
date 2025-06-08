#!/bin/bash

# Set our branch name
BRANCH_NAME="fix-pattern-matching-glob-syntax"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing pattern matching with branch name: ${BRANCH_NAME}"
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test 1: Direct string comparison with glob pattern matching
echo -e "\nTest 1: Direct string comparison with glob pattern matching:"
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
  # Note: This is the critical line - testing with and without quotes
  if [[ "${BRANCH_NAME_LOWER}" == *${kw}* ]]; then
    echo "MATCH FOUND: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
  else
    echo "NO MATCH: branch does not contain keyword '${kw}'"
  fi
done

echo -e "\nTest 1 result: MATCH_FOUND=${MATCH_FOUND}"

# Reset variables
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test 2: Direct string comparison with glob pattern matching (with quotes)
echo -e "\nTest 2: Direct string comparison with glob pattern matching (with quotes):"
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "MATCH FOUND: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
  else
    echo "NO MATCH: branch does not contain keyword '${kw}'"
  fi
done

echo -e "\nTest 2 result: MATCH_FOUND=${MATCH_FOUND}"

# Reset variables
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test 3: Normalized branch name
echo -e "\nTest 3: Normalized branch name:"
NORMALIZED_BRANCH=$(echo "${BRANCH_NAME_LOWER}" | tr -cd 'a-z0-9')
echo "Normalized branch name: ${NORMALIZED_BRANCH}"
for kw in "${KEYWORDS[@]}"; do
  NORMALIZED_KW=$(echo "${kw}" | tr -cd 'a-z0-9')
  echo "Checking if normalized '${NORMALIZED_BRANCH}' contains '${NORMALIZED_KW}'"
  if [[ "${NORMALIZED_BRANCH}" == *${NORMALIZED_KW}* ]]; then
    echo "MATCH FOUND: normalized branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw} (normalized)"
    MATCH_FOUND=true
  else
    echo "NO MATCH: normalized branch does not contain keyword '${kw}'"
  fi
done

echo -e "\nTest 3 result: MATCH_FOUND=${MATCH_FOUND}"

# Reset variables
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Test 4: Using grep
echo -e "\nTest 4: Using grep:"
for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}' using grep"
  if echo "${BRANCH_NAME_LOWER}" | grep -q -F "${kw}"; then
    echo "MATCH FOUND: grep found keyword '${kw}'"
    MATCHED_KEYWORD="${kw} (grep)"
    MATCH_FOUND=true
  else
    echo "NO MATCH: grep did not find keyword '${kw}'"
  fi
done

echo -e "\nTest 4 result: MATCH_FOUND=${MATCH_FOUND}"
