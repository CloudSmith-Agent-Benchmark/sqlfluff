#!/bin/bash

# Create a test log file with errors that match the pattern
cat > test_correct_error.log << 'INNEREOF'

black....................................................................Failed
- hook id: black
- files were modified by this hook

flake8...................................................................Failed
- hook id: flake8
some error: file.py:10:1: E302 expected 2 blank lines, found 1
error: another_error_on_a_line_not_starting_with_dash

INNEREOF

# Test our fixed script
# Fix for multiline output issue when grep returns exit code 1
FAILED_COUNT=0
if grep "Failed" test_correct_error.log &>/dev/null; then
  FAILED_COUNT=$(grep "Failed" test_correct_error.log | wc -l)
fi

MODIFIED_COUNT=0
if grep "files were modified by this hook" test_correct_error.log &>/dev/null; then
  MODIFIED_COUNT=$(grep "files were modified by this hook" test_correct_error.log | wc -l)
fi

# The pattern in the workflow is "^[^-].*error:" which means "error:" not starting with "-"
ERROR_COUNT=0
if grep "^[^-].*error:" test_correct_error.log &>/dev/null; then
  ERROR_COUNT=$(grep "^[^-].*error:" test_correct_error.log | wc -l)
fi

echo "FAILED_COUNT: $FAILED_COUNT"
echo "MODIFIED_COUNT: $MODIFIED_COUNT"
echo "ERROR_COUNT: $ERROR_COUNT"

# Test the condition
if [ "${FAILED_COUNT}" -gt 0 ]; then
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "SUCCESS: All failures are just 'files were modified' messages"
    exit 0
  elif [ "${MODIFIED_COUNT}" -eq 0 ]; then
    echo "ERROR: Pre-commit found actual issues that need to be fixed"
    exit 1
  elif [ "${ERROR_COUNT}" -gt 0 ]; then
    echo "ERROR: Pre-commit found actual errors that need to be fixed"
    exit 1
  else
    echo "WARNING: Pre-commit reported 'files were modified' but no actual errors were found"
    exit 0
  fi
fi
echo "SUCCESS: No failures detected"
exit 0
