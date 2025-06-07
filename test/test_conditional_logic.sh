#!/bin/bash
# Test script to validate the conditional logic fix

# Test case 1: SKIP_FAILURE_CHECKS=true, FAILED_COUNT=0
echo "Test case 1: SKIP_FAILURE_CHECKS=true, FAILED_COUNT=0"
SKIP_FAILURE_CHECKS=true
FAILED_COUNT=0
MODIFIED_COUNT=0
ERROR_COUNT=0

if [ "$SKIP_FAILURE_CHECKS" = true ]; then
  echo "✅ PASS: SKIP_FAILURE_CHECKS=true condition was evaluated correctly"
  exit 0
elif [ "${FAILED_COUNT}" -gt 0 ]; then
  echo "❌ FAIL: Should not reach this condition when SKIP_FAILURE_CHECKS=true"
  exit 1
else
  echo "❌ FAIL: No condition was matched"
  exit 1
fi
