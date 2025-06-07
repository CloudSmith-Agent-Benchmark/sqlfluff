#!/bin/bash
set -e

# Set RAW_LOG environment variable
export RAW_LOG="pre-commit.log"

# Count the number of failures and "files were modified" messages
FAILED_COUNT=$(grep -c "Failed" ${RAW_LOG} || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" ${RAW_LOG} || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" ${RAW_LOG} || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} files
