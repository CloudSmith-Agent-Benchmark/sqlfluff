#!/bin/bash

# Simulate the formatting fix branch environment
export GITHUB_HEAD_REF="fix-workflow-pattern-matching-temp"
export GITHUB_REF="refs/heads/fix-workflow-pattern-matching-temp"
export RAW_LOG="pre-commit.log"
export CS_XML="pre-commit.xml"
export SKIP="no-commit-to-branch"
export PRE_COMMIT_NO_WRITE=1

# Create a mock GITHUB_OUTPUT file
export GITHUB_OUTPUT="github_output.txt"
touch $GITHUB_OUTPUT

# Run the check formatting branch step
echo "Running check formatting branch step..."
cd ..
bash -c "$(grep -A 100 'Check for formatting fix branch' .github/workflows/pre-commit.yml | grep -v 'name:' | grep -v 'id:' | grep -v 'if:' | sed '/^      -/,$d')"

# Read the output
IS_FORMATTING_FIX=$(grep "is_formatting_fix" $GITHUB_OUTPUT | cut -d= -f2)
echo "is_formatting_fix=$IS_FORMATTING_FIX"

# If it's a formatting fix branch, run the formatting fix branch step
if [ "$IS_FORMATTING_FIX" == "true" ]; then
  echo "Running formatting fix branch step..."
  # Extract and run the formatting fix branch step
  bash -c "$(grep -A 50 'Run pre-commit hooks (formatting fix branch)' .github/workflows/pre-commit.yml | grep -v 'name:' | grep -v 'if:' | sed '/^      -/,$d')"
  echo "Exit code: $?"
else
  echo "Not a formatting fix branch, skipping test"
fi
