#!/bin/bash
# Test the fixed workflow script (without pipefail)
RAW_LOG="test_fixed.log"
rm -f ${RAW_LOG}
touch ${RAW_LOG}
set +o pipefail
./simulate_pre_commit.sh | tee ${RAW_LOG}
PRE_COMMIT_STATUS=${PIPESTATUS[0]}

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" ${RAW_LOG} || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" ${RAW_LOG} || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" ${RAW_LOG} || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} \"files were modified\" messages, and ${ERROR_COUNT} errors"
echo "Pre-commit exit status: ${PRE_COMMIT_STATUS}"

# Check if pre-commit failed
if [ "${PRE_COMMIT_STATUS}" -ne 0 ] || [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported \"Failed\" but these were just \"files were modified\" messages"
    exit 0  # Explicitly set success exit code
  fi
fi

echo "Script would have failed before reaching this point"
