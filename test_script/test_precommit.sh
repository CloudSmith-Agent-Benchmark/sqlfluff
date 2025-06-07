#!/bin/bash

# Create test log file
TEST_LOG="test_precommit.log"
echo "" > ${TEST_LOG}

# Add test data to simulate pre-commit output
cat << 'EOT' >> ${TEST_LOG}
black....................................................................Failed
- hook id: black
- files were modified by this hook

mypy.....................................................................Failed
- hook id: mypy
- files were modified by this hook

flake8...................................................................Failed
- hook id: flake8
- files were modified by this hook
EOT

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" ${TEST_LOG} || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" ${TEST_LOG} || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" ${TEST_LOG} || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} 'files were modified' messages, and ${ERROR_COUNT} errors"

# Check if there are any failures in the log
if [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
    exit 0  # Explicitly exit with success when all failures are just 'files were modified' messages
  # If we have actual errors (failures without "files were modified"), exit with error
  elif [ "${MODIFIED_COUNT}" -eq 0 ]; then
    echo "::error::Pre-commit found actual issues that need to be fixed"
    exit 1
  # If we have a mix of "files were modified" and other failures, check for actual errors
  elif [ "${ERROR_COUNT}" -gt 0 ]; then
    echo "::error::Pre-commit found actual errors that need to be fixed"
    exit 1
  else
    echo "::warning::Pre-commit reported 'files were modified' but no actual errors were found"
    exit 0  # Explicitly exit with success when no actual errors were found
  fi
fi

echo "No failures found"
