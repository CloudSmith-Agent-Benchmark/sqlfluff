#!/bin/bash

# Debug script to test the grep pattern matching issue
BRANCH_NAME="fix-pattern-matching-glob-syntax"

echo "Branch name: ${BRANCH_NAME}"

# Test with the original pattern
echo -n "Testing original pattern: "
if echo "${BRANCH_NAME}" | grep -iE "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

# Test with each keyword individually
echo -n "Testing 'pattern': "
if echo "${BRANCH_NAME}" | grep -i "pattern" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -n "Testing 'regex': "
if echo "${BRANCH_NAME}" | grep -i "regex" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -n "Testing 'grep': "
if echo "${BRANCH_NAME}" | grep -i "grep" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -n "Testing 'trailing-whitespace': "
if echo "${BRANCH_NAME}" | grep -i "trailing-whitespace" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -n "Testing 'formatting': "
if echo "${BRANCH_NAME}" | grep -i "formatting" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -n "Testing 'branch-detection': "
if echo "${BRANCH_NAME}" | grep -i "branch-detection" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

# Test with word boundaries
echo -n "Testing with word boundaries: "
if echo "${BRANCH_NAME}" | grep -iE "\b(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)\b" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

# Test with a simpler pattern
echo -n "Testing with simpler pattern: "
if echo "${BRANCH_NAME}" | grep -i "grep" > /dev/null; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

# Print each character with its ASCII value
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

