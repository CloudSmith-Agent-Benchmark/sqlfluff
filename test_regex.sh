#!/bin/bash

# Test with the branch name that should match
BRANCH_NAME="fix-bash-pattern-matching"

echo "Testing with branch name: $BRANCH_NAME"

# Test with quotes (incorrect)
if [[ "${BRANCH_NAME}" =~ .*fix.*pattern.* ]]; then
  echo "QUOTED TEST: Branch matches the pattern .*fix.*pattern.*"
else
  echo "QUOTED TEST: Branch does NOT match the pattern .*fix.*pattern.*"
fi

# Test without quotes (correct)
if [[ ${BRANCH_NAME} =~ .*fix.*pattern.* ]]; then
  echo "UNQUOTED TEST: Branch matches the pattern .*fix.*pattern.*"
else
  echo "UNQUOTED TEST: Branch does NOT match the pattern .*fix.*pattern.*"
fi