#!/bin/bash
# Test the original workflow script (with pipefail)
set -o pipefail
RAW_LOG="test_original.log"
rm -f ${RAW_LOG}
touch ${RAW_LOG}
./simulate_pre_commit.sh | tee ${RAW_LOG}

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" ${RAW_LOG} || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" ${RAW_LOG} || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" ${RAW_LOG} || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} \"files were modified\" messages, and ${ERROR_COUNT} errors"

# Check if there are any failures in the log
if [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported \"Failed\" but these were just \"files were modified\" messages"
    exit 0  # Explicitly set success exit code
  fi
fi

echo "Script would have failed before reaching this point"
