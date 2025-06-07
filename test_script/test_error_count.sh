#!/bin/bash

# Create a test log file
echo "" > test.log
echo "black....................................................................Failed" >> test.log
echo "- hook id: black" >> test.log
echo "- files were modified by this hook" >> test.log
echo "" >> test.log

# Test our fixed script
# Fix for multiline output issue when grep returns exit code 1
FAILED_COUNT=0
if grep "Failed" test.log &>/dev/null; then
  FAILED_COUNT=$(grep "Failed" test.log | wc -l)
fi

MODIFIED_COUNT=0
if grep "files were modified by this hook" test.log &>/dev/null; then
  MODIFIED_COUNT=$(grep "files were modified by this hook" test.log | wc -l)
fi

ERROR_COUNT=0
if grep "^[^-].*error:" test.log &>/dev/null; then
  ERROR_COUNT=$(grep "^[^-].*error:" test.log | wc -l)
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
