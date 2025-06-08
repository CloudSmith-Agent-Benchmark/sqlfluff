#!/bin/bash

# Test branch name
BRANCH_NAME="fix-pre-commit-workflow-pattern-matching"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing pattern matching for branch: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")

# Test direct match
if [[ "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-cloudsmith" || 
       "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-workflow-v2" || 
       "${BRANCH_NAME_LOWER}" == "fix-pre-commit-workflow-pattern-matching" ]]; then
  echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
else
  echo "No direct match found"
fi

# Test substring matching with ==
echo -e "\nTesting substring matching with == operator:"
for kw in "${KEYWORDS[@]}"; do
  echo -n "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}': "
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "YES"
  else
    echo "NO"
  fi
done

# Test regex matching with =~ (original approach)
echo -e "\nTesting regex matching with =~ operator (original approach):"
for kw in "${KEYWORDS[@]}"; do
  echo -n "Checking if '${BRANCH_NAME_LOWER}' matches regex '${kw}': "
  if [[ "${BRANCH_NAME_LOWER}" =~ ${kw} ]]; then
    echo "YES"
  else
    echo "NO"
  fi
done

# Test grep matching
echo -e "\nTesting grep matching:"
for kw in "${KEYWORDS[@]}"; do
  echo -n "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}' using grep: "
  if echo "${BRANCH_NAME_LOWER}" | grep -q -F "${kw}"; then
    echo "YES"
  else
    echo "NO"
  fi
done