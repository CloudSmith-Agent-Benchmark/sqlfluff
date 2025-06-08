#!/bin/bash

echo "Testing pipefail behavior..."

echo "Test 1: Without pipefail"
(
  # Run a command that fails and pipe its output
  (echo "Command output" && false) | cat
  echo "Exit code after pipe: $?"
  # This should still execute and the script should exit with 0
  exit 0
)
EXIT_CODE=$?
echo "Final exit code: $EXIT_CODE"

echo "Test 2: With pipefail"
(
  set -o pipefail
  # Run a command that fails and pipe its output
  (echo "Command output" && false) | cat
  echo "Exit code after pipe: $?"
  # This should still execute but the script should exit with non-zero
  exit 0
)
EXIT_CODE=$?
echo "Final exit code: $EXIT_CODE"
