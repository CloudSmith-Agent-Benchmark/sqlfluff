#!/bin/bash

# Test script to validate the fix for the pre-commit workflow

# Test 1: With set -o pipefail (original behavior)
echo "Test 1: With set -o pipefail (original behavior)"
(
  set -o pipefail
  # This command will fail (exit code 1) but the output is piped to tee
  (echo "Running command that fails" && false) | tee /tmp/output.log
  # This exit 0 should be ignored due to pipefail
  echo "This line should not prevent failure"
  exit 0
)
EXIT_CODE=$?
echo "Exit code: $EXIT_CODE"
if [ $EXIT_CODE -ne 0 ]; then
  echo "✅ Test 1 passed: Script failed as expected with pipefail set"
else
  echo "❌ Test 1 failed: Script should have failed with pipefail set"
fi

# Test 2: Without set -o pipefail (our fix)
echo "Test 2: Without set -o pipefail (our fix)"
(
  # No pipefail set
  # This command will fail (exit code 1) but the output is piped to tee
  (echo "Running command that fails" && false) | tee /tmp/output.log
  # This exit 0 should take precedence
  echo "This line should prevent failure"
  exit 0
)
EXIT_CODE=$?
echo "Exit code: $EXIT_CODE"
if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ Test 2 passed: Script succeeded as expected without pipefail"
else
  echo "❌ Test 2 failed: Script should have succeeded without pipefail"
fi

# Test 3: With explicit exit code capture (our alternative fix)
echo "Test 3: With explicit exit code capture (our alternative fix)"
(
  set -o pipefail
  # This command will fail (exit code 1) but the output is piped to tee
  (echo "Running command that fails" && false) | tee /tmp/output.log
  # Capture exit code
  COMMAND_EXIT_CODE=$?
  echo "Command exited with code: $COMMAND_EXIT_CODE"
  # Always exit with success
  exit 0
)
EXIT_CODE=$?
echo "Exit code: $EXIT_CODE"
if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ Test 3 passed: Script succeeded with explicit exit code handling"
else
  echo "❌ Test 3 failed: Script should have succeeded with explicit exit code handling"
fi

echo "All tests completed"
