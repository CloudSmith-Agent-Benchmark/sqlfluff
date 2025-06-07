#!/bin/bash

# Set up test variables
BRANCH_NAME="fix-trailing-whitespace-in-workflow-1749317728"
FAILED_COUNT=7
MODIFIED_COUNT=7
ERROR_COUNT=0
RAW_LOG="/tmp/test.log"
SKIP_FAILURE_CHECKS=false

echo "Testing with branch name: $BRANCH_NAME"
echo "FAILED_COUNT=$FAILED_COUNT, MODIFIED_COUNT=$MODIFIED_COUNT, ERROR_COUNT=$ERROR_COUNT"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER="${BRANCH_NAME,,}"
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Check if branch starts with fix-
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  
  # Check for keywords
  if [[ "$BRANCH_NAME_LOWER" == *pattern* ]] ||
     [[ "$BRANCH_NAME_LOWER" == *regex* ]] ||
     [[ "$BRANCH_NAME_LOWER" == *trailing* ]] ||
     [[ "$BRANCH_NAME_LOWER" == *whitespace* ]] ||
     [[ "$BRANCH_NAME_LOWER" == *format* ]] ||
     [[ "$BRANCH_NAME_LOWER" == *branch* ]] ||
     [[ "$BRANCH_NAME_LOWER" == *detect* ]]; then
    echo "Branch contains formatting keywords: YES"
    echo "::warning::On branch ${BRANCH_NAME} which is fixing formatting issues - allowing pre-commit failures related to formatting"
    # Set flag to skip failure checks instead of exiting
    SKIP_FAILURE_CHECKS=true
  else
    echo "Branch contains formatting keywords: NO"
  fi
else
  echo "Branch starts with 'fix-': NO"
fi

echo "SKIP_FAILURE_CHECKS=$SKIP_FAILURE_CHECKS"

# Only check for failures if we're not on a formatting fix branch
if [ "$SKIP_FAILURE_CHECKS" = false ] && [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
    # Success - no need to exit
  # If we have actual errors (failures without "files were modified"), exit with error
  elif [ "${MODIFIED_COUNT}" -eq 0 ]; then
    echo "::error::Pre-commit found actual issues that need to be fixed"
    echo "Would exit with code 1"
  # If we have a mix of "files were modified" and other failures, check for actual errors
  elif [ "${ERROR_COUNT}" -gt 0 ]; then
    echo "::error::Pre-commit found actual errors that need to be fixed"
    echo "Would exit with code 1"
  else
    echo "::warning::Pre-commit reported 'files were modified' but no actual errors were found"
    # Success - no need to exit
  fi
elif [ "$SKIP_FAILURE_CHECKS" = true ]; then
  echo "::notice::Skipping failure checks because this is a formatting fix branch"
fi

echo "Test completed successfully"