#!/bin/bash
set -e

# Create a test log file
cat > pre-commit.log << 'LOGEOF'
[INFO] Initializing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Initializing environment for https://github.com/psf/black.
black....................................................................Failed
- hook id: black
- files were modified by this hook

mypy.....................................................................Failed
- hook id: mypy
- files were modified by this hook

flake8...................................................................Failed
- hook id: flake8
- files were modified by this hook
LOGEOF

# Set branch name for testing
export BRANCH_NAME="fix-pattern-matching"

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" pre-commit.log || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" pre-commit.log || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" pre-commit.log || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} 'files were modified' messages, and ${ERROR_COUNT} errors"
echo "Current branch name: ${BRANCH_NAME}"

# Extract the branch pattern matching logic from the workflow file
PATTERN_LOGIC=$(grep -A5 "Check if we're on a branch specifically fixing formatting issues" ../.github/workflows/pre-commit.yml)
echo -e "\nPattern logic from workflow file:"
echo "$PATTERN_LOGIC"

# Test the pattern matching
if [[ "${BRANCH_NAME}" =~ fix-(trailing-whitespace|pattern-matching|formatting) ]]; then
  echo -e "\nPattern match SUCCESS: Branch '${BRANCH_NAME}' matches the pattern"
  echo "This would exit with code 0 in the workflow"
else
  echo -e "\nPattern match FAILURE: Branch '${BRANCH_NAME}' does not match the pattern"
  echo "This would continue to the next check in the workflow"
fi

# Test the modified count logic
if [ "${FAILED_COUNT}" -gt 0 ]; then
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo -e "\nModified count check SUCCESS: All failures are 'files were modified' messages"
    echo "This would exit with code 0 in the workflow"
  else
    echo -e "\nModified count check FAILURE: Not all failures are 'files were modified' messages"
    echo "This would exit with code 1 in the workflow"
  fi
fi
