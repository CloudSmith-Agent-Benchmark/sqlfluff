#!/bin/bash
BRANCH_NAME="fix-pattern-matching-bash"
echo "Branch name: $BRANCH_NAME"

# First test direct pattern matching
echo "Direct test - Contains 'pattern': $([[ "$BRANCH_NAME" == *pattern* ]] && echo "true" || echo "false")"

# Now test the loop from the workflow
patterns=("pattern" "regex" "trailing-whitespace" "formatting" "syntax" "conditional")
echo "Testing loop from workflow:"
for pattern in "${patterns[@]}"; do
  if [[ "$BRANCH_NAME" == *${pattern}* ]]; then
    echo "Found match with pattern: ${pattern}"
  else
    echo "No match with pattern: ${pattern}"
  fi
done
