#!/bin/bash

# Test branch name pattern matching
BRANCH_NAME="fix-pattern-matching"
echo "Testing branch name: $BRANCH_NAME"

if [[ "${BRANCH_NAME}" =~ fix-(trailing-whitespace|pattern-matching|formatting) ]]; then
  echo "SUCCESS: Branch name matches the pattern"
else
  echo "FAILURE: Branch name does not match the pattern"
fi

# Create a test log file
cat > pre-commit.log << 'LOGEOF'
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

# Count failures and modified files
FAILED_COUNT=$(grep -c "Failed" pre-commit.log || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" pre-commit.log || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" pre-commit.log || echo 0)

echo "Found $FAILED_COUNT failures, $MODIFIED_COUNT 'files were modified' messages, and $ERROR_COUNT errors"

if [ "$FAILED_COUNT" -eq "$MODIFIED_COUNT" ]; then
  echo "SUCCESS: All failures are 'files were modified' messages"
else
  echo "FAILURE: Not all failures are 'files were modified' messages"
fi
