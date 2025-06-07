#!/bin/bash
BRANCH_NAME="fix-regex-pattern-matching"
echo "Testing branch name: ${BRANCH_NAME}"

# Test with the exact grep command from the workflow
echo "Using grep command from workflow:"
if echo "${BRANCH_NAME}" | grep -iE '(pattern|regex|trailing-whitespace|formatting|branch-detection)' > /dev/null; then
  echo "MATCH FOUND"
else
  echo "NO MATCH"
fi

# Test with a different grep pattern
echo -e "\nUsing alternative grep pattern:"
if echo "${BRANCH_NAME}" | grep -iE "(pattern|regex|trailing-whitespace|formatting|branch-detection)" > /dev/null; then
  echo "MATCH FOUND"
else
  echo "NO MATCH"
fi

# Test with bash pattern matching
echo -e "\nUsing bash pattern matching:"
shopt -s nocasematch
if [[ ${BRANCH_NAME} =~ (pattern|regex|trailing-whitespace|formatting|branch-detection) ]]; then
  echo "MATCH FOUND"
else
  echo "NO MATCH"
fi
shopt -u nocasematch

# Test each keyword individually
echo -e "\nTesting each keyword individually:"
for keyword in "pattern" "regex" "trailing-whitespace" "formatting" "branch-detection"; do
  if echo "${BRANCH_NAME}" | grep -i "${keyword}" > /dev/null; then
    echo "${keyword}: MATCH FOUND"
  else
    echo "${keyword}: NO MATCH"
  fi
done
