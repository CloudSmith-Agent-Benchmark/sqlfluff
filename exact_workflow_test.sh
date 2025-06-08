#!/bin/bash

# Set our branch name
BRANCH_NAME="fix-pattern-matching-glob-syntax"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing pattern matching with branch name: ${BRANCH_NAME}"
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Define keywords to look for - exactly as in the workflow
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")
MATCH_FOUND=false
MATCHED_KEYWORD=""

# Use bash's native string operations for more consistent behavior across environments
for kw in "${KEYWORDS[@]}"; do
  # Case-insensitive substring check using bash glob pattern matching
  # IMPORTANT: Do not quote the pattern part (*${kw}*) as it prevents glob pattern matching
  # Explicitly print the comparison being made for debugging
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
  if [[ "${BRANCH_NAME_LOWER}" == *${kw}* ]]; then
    echo "Match found: branch contains keyword '${kw}'"
    MATCHED_KEYWORD="${kw}"
    MATCH_FOUND=true
    break
  fi
done

# Summary of matching results
if [[ "$MATCH_FOUND" == "true" ]]; then
  echo "Branch contains formatting keywords: YES (matched: ${MATCHED_KEYWORD})"
else
  echo "Branch contains formatting keywords: NO"
fi
