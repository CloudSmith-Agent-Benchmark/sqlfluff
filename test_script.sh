#!/bin/bash
BRANCH_NAME="fix-workflow-conditional-keywords-solution"

echo "Debug: Starts with fix-: $([[ "${BRANCH_NAME}" =~ ^fix- ]] && echo "true" || echo "false")"
echo "Debug: Contains conditional-keywords: $([[ "${BRANCH_NAME}" == *"conditional-keywords"* ]] && echo "true" || echo "false")"

if [[ "${BRANCH_NAME}" =~ ^fix- ]] && { [[ "${BRANCH_NAME}" == *"pattern"* ]] || [[ "${BRANCH_NAME}" == *"regex"* ]] || [[ "${BRANCH_NAME}" == *"trailing-whitespace"* ]] || [[ "${BRANCH_NAME}" == *"formatting"* ]] || [[ "${BRANCH_NAME}" == *"syntax"* ]] || [[ "${BRANCH_NAME}" == *"conditional-keywords"* ]]; } then
  echo "Branch matches the condition"
else
  echo "Branch doesn't match the condition"
fi
