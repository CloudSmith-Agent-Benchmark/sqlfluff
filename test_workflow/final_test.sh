#!/bin/bash

# Create a mock pre-commit script that always fails
mkdir -p /tmp/mock_bin
cat > /tmp/mock_bin/pre-commit << 'MOCK'
#!/bin/bash
echo "Running mock pre-commit that always fails"
echo "Failed"
echo "files were modified by this hook"
exit 1
MOCK
chmod +x /tmp/mock_bin/pre-commit
export PATH="/tmp/mock_bin:$PATH"
export RAW_LOG="/tmp/pre-commit.log"

echo "Test 1: Original behavior with pipefail"
(
  set -o pipefail
  # Clean pre-commit cache to remove phantom files
  pre-commit clean
  pre-commit gc
  # Remove any existing log file and create a new empty one
  rm -f ${RAW_LOG}
  touch ${RAW_LOG}
  # Run pre-commit on all files in check-only mode and ensure output is captured
  pre-commit run --show-diff-on-failure --color=always --all-files | tee ${RAW_LOG}

  # Log that we're skipping validation for formatting fix branch
  echo "::warning::Skipping pre-commit validation for formatting fix branch"
  # Always exit with success for formatting fix branches regardless of pre-commit exit code
  exit 0
)
EXIT_CODE=$?
echo "Exit code: $EXIT_CODE"
if [ $EXIT_CODE -ne 0 ]; then
  echo "✅ Test 1 passed: Script failed as expected with pipefail set"
else
  echo "❌ Test 1 failed: Script should have failed with pipefail set"
fi

echo "Test 2: Fixed behavior without pipefail"
(
  # No pipefail set
  # Clean pre-commit cache to remove phantom files
  pre-commit clean
  pre-commit gc
  # Remove any existing log file and create a new empty one
  rm -f ${RAW_LOG}
  touch ${RAW_LOG}
  # Run pre-commit on all files in check-only mode and ensure output is captured
  pre-commit run --show-diff-on-failure --color=always --all-files | tee ${RAW_LOG}

  # Log that we're skipping validation for formatting fix branch
  echo "::warning::Skipping pre-commit validation for formatting fix branch"
  # Always exit with success for formatting fix branches regardless of pre-commit exit code
  exit 0
)
EXIT_CODE=$?
echo "Exit code: $EXIT_CODE"
if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ Test 2 passed: Script succeeded as expected without pipefail"
else
  echo "❌ Test 2 failed: Script should have succeeded without pipefail"
fi

echo "Test 3: Fixed behavior with explicit exit code capture"
(
  set -o pipefail
  # Clean pre-commit cache to remove phantom files
  pre-commit clean
  pre-commit gc
  # Remove any existing log file and create a new empty one
  rm -f ${RAW_LOG}
  touch ${RAW_LOG}
  # Run pre-commit on all files in check-only mode and ensure output is captured
  pre-commit run --show-diff-on-failure --color=always --all-files | tee ${RAW_LOG}
  # Capture the exit code explicitly
  PRE_COMMIT_EXIT_CODE=$?
  
  # Log that we're skipping validation for formatting fix branch
  echo "::warning::Skipping pre-commit validation for formatting fix branch (pre-commit exited with code ${PRE_COMMIT_EXIT_CODE})"
  # Always exit with success for formatting fix branches regardless of pre-commit exit code
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
