#!/bin/bash

BRANCH_NAME="fix-workflow-newline-and-pattern-matching"
echo "Testing pattern matching for branch: ${BRANCH_NAME}"

# Test 1: Basic grep
echo -n "Test 1 (Basic grep): "
echo "${BRANCH_NAME}" | grep -i "pattern" > /dev/null && echo "MATCH" || echo "NO MATCH"

# Test 2: Extended regex grep
echo -n "Test 2 (Extended regex grep): "
echo "${BRANCH_NAME}" | grep -i -E "pattern" > /dev/null && echo "MATCH" || echo "NO MATCH"

# Test 3: Full pattern with -q
echo -n "Test 3 (Full pattern with -q): "
echo "${BRANCH_NAME}" | grep -i -E -q "pattern|regex|trailing-whitespace|formatting|branch-detection|grep|escaping" && echo "MATCH" || echo "NO MATCH"

# Test 4: Word boundaries
echo -n "Test 4 (Word boundaries): "
echo "${BRANCH_NAME}" | grep -i -E -q "\bpattern\b" && echo "MATCH" || echo "NO MATCH"

# Test 5: Substring extraction
echo "Test 5 (Substring extraction):"
echo "${BRANCH_NAME}" | grep -o "pattern"

# Test 6: Debug each character
echo "Test 6 (Character by character):"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Test 7: Check if pattern is part of a word
echo -n "Test 7 (Check if pattern is part of a word): "
if [[ "${BRANCH_NAME}" == *"pattern"* ]]; then
  echo "MATCH using bash string comparison"
else
  echo "NO MATCH using bash string comparison"
fi

