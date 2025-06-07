#!/bin/bash

# Test branch name
BRANCH_NAME="fix-regex-pattern-substring-detection"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert to lowercase
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Test the original regex pattern (without grouping)
if [[ ${BRANCH_NAME_LOWER} =~ pattern|regex|grep|trailing-whitespace|formatting|branch-detection ]]; then
  echo "Original regex (without grouping): MATCHED - ${BASH_REMATCH[0]}"
else
  echo "Original regex (without grouping): NOT MATCHED"
fi

# Test the fixed regex pattern (with grouping)
if [[ ${BRANCH_NAME_LOWER} =~ (pattern|regex|grep|trailing-whitespace|formatting|branch-detection) ]]; then
  echo "Fixed regex (with grouping): MATCHED - ${BASH_REMATCH[0]}"
else
  echo "Fixed regex (with grouping): NOT MATCHED"
fi

# Test the original grep pattern
if echo "${BRANCH_NAME_LOWER}" | grep -E "pattern|regex|grep|trailing-whitespace|formatting|branch-detection" > /dev/null; then
  echo "Original grep pattern: MATCHED"
else
  echo "Original grep pattern: NOT MATCHED"
fi

# Test the fixed grep pattern
if echo "${BRANCH_NAME_LOWER}" | grep -E "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)" > /dev/null; then
  echo "Fixed grep pattern: MATCHED"
else
  echo "Fixed grep pattern: NOT MATCHED"
fi