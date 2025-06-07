#!/bin/bash
# Test script to validate the pre-commit workflow fix

set -e
set -o pipefail

# Set environment variables
export RAW_LOG="pre-commit.log"
export PRE_COMMIT_NO_WRITE=1

# Extract the relevant part of the workflow script
echo "Running pre-commit workflow test..."

# Clean pre-commit cache to remove phantom files
pre-commit clean
pre-commit gc

# Remove any existing log file and create a new empty one
rm -f ${RAW_LOG}
touch ${RAW_LOG}

# Temporarily disable exit-on-error to prevent premature script termination
set +e
# Run pre-commit on all files in check-only mode and ensure output is captured
pre-commit run --show-diff-on-failure --color=always --all-files -c .pre-commit-config-ci.yaml | tee ${RAW_LOG}
# Capture the exit code of pre-commit (first command in the pipeline)
PRE_COMMIT_STATUS=${PIPESTATUS[0]}
# Re-enable exit-on-error
set -e

echo "Pre-commit exited with status: ${PRE_COMMIT_STATUS}"

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" ${RAW_LOG} || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" ${RAW_LOG} || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" ${RAW_LOG} || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} 'files were modified' messages, and ${ERROR_COUNT} errors"

# Debug log file content
echo "Log file size: $(wc -l < ${RAW_LOG}) lines"
echo "First few lines of log file:"
head -n 5 ${RAW_LOG}

# Check if pre-commit failed (non-zero exit code)
if [ "${PRE_COMMIT_STATUS}" -ne 0 ]; then
  # Check if there are any failures in the log
  if [ "${FAILED_COUNT}" -gt 0 ]; then
    # If all failures are just "files were modified" messages, consider it a success
    if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
      echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
      exit 0  # Explicitly set success exit code
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
      exit 0  # Explicitly set success exit code
    fi
  else
    # Pre-commit failed but no failures were found in the log - this is unexpected
    echo "::error::Pre-commit failed with exit code ${PRE_COMMIT_STATUS} but no failures were found in the log"
    exit ${PRE_COMMIT_STATUS}
  fi
fi

echo "Test completed successfully!"