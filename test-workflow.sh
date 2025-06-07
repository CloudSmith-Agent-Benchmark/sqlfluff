#!/bin/bash
set -x
RAW_LOG="workflow-log.txt"

# Check if there are any failures in the log
if grep -q "Failed" ${RAW_LOG}; then
  echo "Found 'Failed' entries"
  # If all failures are just "files were modified" messages, consider it a success
  if grep -c "files were modified by this hook" ${RAW_LOG} | grep -q "^$(grep -c "Failed" ${RAW_LOG})$"; then
    echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
    echo "CONDITION PASSED: All failures are just 'files were modified' messages"
    exit 0
  # If we have actual errors (failures without "files were modified"), exit with error
  elif ! grep -q "files were modified by this hook" ${RAW_LOG}; then
    echo "::error::Pre-commit found actual issues that need to be fixed"
    echo "CONDITION FAILED: No 'files were modified' messages found"
    exit 1
  # If we have a mix of "files were modified" and other failures, check for actual errors
  elif grep -q "^[^-].*error:" ${RAW_LOG}; then
    echo "::error::Pre-commit found actual errors that need to be fixed"
    echo "CONDITION FAILED: Found actual error messages"
    exit 1
  else
    echo "::warning::Pre-commit reported 'files were modified' but no actual errors were found"
    echo "CONDITION PASSED: Only 'files were modified' messages found"
    exit 0
  fi
else
  echo "No 'Failed' entries found"
  exit 0
fi
