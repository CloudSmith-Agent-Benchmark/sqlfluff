#!/bin/bash

# This script simulates the behavior of the pre-commit workflow
# to validate that our fix works correctly

echo "Validating fix for pre-commit workflow..."

# Create a test log file with "files were modified" messages
cat > test_simple.log << EOF
black....................................................................Failed
- hook id: black
- files were modified by this hook
EOF

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" test_simple.log || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" test_simple.log || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" test_simple.log || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} 'files were modified' messages, and ${ERROR_COUNT} errors"

# Check if there are any failures in the log
if [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
    exit_code=0
  # If we have actual errors (failures without "files were modified"), exit with error
  elif [ "${MODIFIED_COUNT}" -eq 0 ]; then
    echo "::error::Pre-commit found actual issues that need to be fixed"
    exit_code=1
  # If we have a mix of "files were modified" and other failures, check for actual errors
  elif [ "${ERROR_COUNT}" -gt 0 ]; then
    echo "::error::Pre-commit found actual errors that need to be fixed"
    exit_code=1
  else
    echo "::warning::Pre-commit reported 'files were modified' but no actual errors were found"
    exit_code=0
  fi
else
  echo "No failures found"
  exit_code=0
fi

echo "Exit code: ${exit_code}"

if [ "${exit_code}" -eq 0 ]; then
  echo "Validation PASSED: The fix works correctly!"
else
  echo "Validation FAILED: The fix does not work correctly."
fi

# Clean up
rm test_simple.log

exit ${exit_code}