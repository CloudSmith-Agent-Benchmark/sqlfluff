#!/bin/bash
set -e

# Setup test environment
RAW_LOG="test/pre-commit.log"
echo "[INFO] Initializing environment for https://github.com/pre-commit/pre-commit-hooks." > ${RAW_LOG}
echo "black....................................................................Failed" >> ${RAW_LOG}
echo "- hook id: black" >> ${RAW_LOG}
echo "- files were modified by this hook" >> ${RAW_LOG}
echo "mypy.....................................................................Failed" >> ${RAW_LOG}
echo "- hook id: mypy" >> ${RAW_LOG}
echo "- files were modified by this hook" >> ${RAW_LOG}

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" ${RAW_LOG} || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" ${RAW_LOG} || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" ${RAW_LOG} || echo 0)

# Ensure variables are numeric to prevent comparison issues
FAILED_COUNT=$(echo "${FAILED_COUNT}" | tr -d '[:space:]')
MODIFIED_COUNT=$(echo "${MODIFIED_COUNT}" | tr -d '[:space:]')
ERROR_COUNT=$(echo "${ERROR_COUNT}" | tr -d '[:space:]')

# Set default values if empty
FAILED_COUNT=${FAILED_COUNT:-0}
MODIFIED_COUNT=${MODIFIED_COUNT:-0}
ERROR_COUNT=${ERROR_COUNT:-0}

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} 'files were modified' messages, and ${ERROR_COUNT} errors"

# Debug output for variable values to help with troubleshooting
echo "FAILED_COUNT=${FAILED_COUNT} (type: $([ "${FAILED_COUNT}" -eq "${FAILED_COUNT}" ] 2>/dev/null && echo "numeric" || echo "non-numeric"))"
echo "MODIFIED_COUNT=${MODIFIED_COUNT} (type: $([ "${MODIFIED_COUNT}" -eq "${MODIFIED_COUNT}" ] 2>/dev/null && echo "numeric" || echo "non-numeric"))"
echo "ERROR_COUNT=${ERROR_COUNT} (type: $([ "${ERROR_COUNT}" -eq "${ERROR_COUNT}" ] 2>/dev/null && echo "numeric" || echo "non-numeric"))"

# Check if there are any failures in the log
if [[ "${FAILED_COUNT}" =~ ^[0-9]+$ ]] && [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [[ "${MODIFIED_COUNT}" =~ ^[0-9]+$ ]] && [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
    echo "TEST PASSED: Would exit with success code 0"
  # If we have actual errors (failures without "files were modified"), exit with error
  elif [[ "${MODIFIED_COUNT}" =~ ^[0-9]+$ ]] && [ "${MODIFIED_COUNT}" -eq 0 ]; then
    echo "::error::Pre-commit found actual issues that need to be fixed"
    echo "TEST FAILED: Would exit with error code 1"
  # If we have a mix of "files were modified" and other failures, check for actual errors
  elif [[ "${ERROR_COUNT}" =~ ^[0-9]+$ ]] && [ "${ERROR_COUNT}" -gt 0 ]; then
    echo "::error::Pre-commit found actual errors that need to be fixed"
    echo "TEST FAILED: Would exit with error code 1"
  else
    echo "::warning::Pre-commit reported 'files were modified' but no actual errors were found"
    echo "TEST PASSED: Would exit with success code 0"
  fi
else
  echo "No failures found"
  echo "TEST PASSED: Would continue execution"
fi
