#!/bin/bash

BRANCH_NAME="fix-branch-matching-logic-solution"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing branch name: ${BRANCH_NAME_LOWER}"

# Test direct match
if [[ "${BRANCH_NAME_LOWER}" == "fix-branch-matching-logic" ||
      "${BRANCH_NAME_LOWER}" == "fix-branch-matching-logic-solution" ]]; then
  echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
  exit 0
fi

# Test keyword match
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "format-branch" "branch-format" "detection" "newline" "workflow" "temp" "fix-format" "format-fix" "list" "match" "direct" "logic")

for kw in "${KEYWORDS[@]}"; do
  echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "Match found: branch contains keyword '${kw}'"
    exit 0
  fi
done

echo "No match found"
exit 1