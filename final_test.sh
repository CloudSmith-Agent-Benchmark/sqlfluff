#!/bin/bash

# Set the branch name that's failing to match
BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing branch name: '${BRANCH_NAME_LOWER}'"

# Test direct match with the exact condition from the workflow file
echo -e "\nTesting direct match with the exact condition from the workflow file:"
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
  echo "MATCH: Direct match found in the list"
else
  echo "NO MATCH: Branch name not found in the direct match list"
fi

# Test with a simplified list to narrow down the issue
echo -e "\nTesting with a simplified list:"
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
  echo "MATCH: Direct match with single branch name succeeded"
else
  echo "NO MATCH: Direct match with single branch name failed"
fi

# Test with keywords to see if any match
echo -e "\nTesting with keywords:"
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
  if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
    echo "MATCH: Branch contains keyword '${kw}'"
    MATCH_FOUND=true
    break
  fi
done

if [[ "$MATCH_FOUND" != "true" ]]; then
  echo "NO MATCH: Branch does not contain any of the keywords"
fi

# Test with a modified branch name to see if the length is an issue
echo -e "\nTesting with a shorter branch name:"
SHORT_BRANCH="fix-workflow-direct-match-list"
if [[ "${SHORT_BRANCH}" == "fix-workflow-direct-match-list" ]]; then
  echo "MATCH: Short branch name matched"
else
  echo "NO MATCH: Short branch name did not match"
fi

# Test with the exact branch name from the list in the workflow
echo -e "\nTesting with the exact string from the workflow file:"
EXACT_MATCH="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
if [[ "${BRANCH_NAME_LOWER}" == "${EXACT_MATCH}" ]]; then
  echo "MATCH: Exact match with variable succeeded"
else
  echo "NO MATCH: Exact match with variable failed"
fi

# Test with a different shell to see if it's a shell-specific issue
echo -e "\nTesting with sh shell:"
sh -c "if [ \"${BRANCH_NAME_LOWER}\" = \"fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution\" ]; then echo 'MATCH: sh shell matched'; else echo 'NO MATCH: sh shell did not match'; fi"

# Test with a different comparison operator
echo -e "\nTesting with = operator instead of ==:"
if [ "${BRANCH_NAME_LOWER}" = "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]; then
  echo "MATCH: = operator matched"
else
  echo "NO MATCH: = operator did not match"
fi

# Test with line continuation to see if that's affecting the comparison
echo -e "\nTesting with line continuation:"
if [[ "${BRANCH_NAME_LOWER}" == \
"fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
  echo "MATCH: Line continuation matched"
else
  echo "NO MATCH: Line continuation did not match"
fi

# Test with a different formatting of the if statement
echo -e "\nTesting with different if statement formatting:"
if 
  [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]
then
  echo "MATCH: Different if statement formatting matched"
else
  echo "NO MATCH: Different if statement formatting did not match"
fi
