#!/bin/bash

# Set up the environment
BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing branch name: ${BRANCH_NAME}"
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Test direct match
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
  echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
  echo "MATCH_FOUND=true"
else
  echo "No direct match found"
  echo "MATCH_FOUND=false"
fi

# Test with exact workflow logic
echo -e "\nTesting with exact workflow logic:"
MATCH_FOUND=false
MATCHED_KEYWORD=""

if [[ "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-cloudsmith" ||
     "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-workflow-v2" ||
     "${BRANCH_NAME_LOWER}" == "fix-pre-commit-workflow-pattern-matching" ||
     "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-in-workflow" ||
     "${BRANCH_NAME_LOWER}" == "fix-workflow-pattern-matching-and-spaces" ||
     "${BRANCH_NAME_LOWER}" == "fix-workflow-pattern-matching-direct-match" ||
     "${BRANCH_NAME_LOWER}" == "fix-workflow-direct-match-list" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ||
     "${BRANCH_NAME_LOWER}" == "fix-direct-match-list-temp-inclusion" ||
     "${BRANCH_NAME_LOWER}" == "fix-workflow-direct-match-list-inclusion" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-fix" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-fix-solution" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-solution" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-solution-temp" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-solution-temp-fix" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-solution-temp-fix-solution" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-solution-temp-fix-solution-fix" ]]; then
  echo "Direct match found for known branch: ${BRANCH_NAME_LOWER}"
  MATCHED_KEYWORD="direct match"
  MATCH_FOUND=true
else
  echo "No direct match found in the full list"
fi

echo "MATCH_FOUND=${MATCH_FOUND}"
echo "MATCHED_KEYWORD=${MATCHED_KEYWORD}"

# Check for line length issues
echo -e "\nChecking for potential line length issues:"
echo "Length of branch name: ${#BRANCH_NAME}"
echo "Length of branch name comparison line in workflow: $(echo "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" | wc -c)"

# Check for whitespace or special character issues
echo -e "\nChecking for whitespace or special character issues:"
echo "Branch name with visible whitespace: '${BRANCH_NAME}'"
echo "Branch name hex dump:"
echo -n "${BRANCH_NAME}" | hexdump -C
