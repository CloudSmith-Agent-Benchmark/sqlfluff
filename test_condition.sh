#!/bin/bash

# Test the conditional with the branch name that was used in the workflow run
BRANCH_NAME="fix-workflow-syntax-exemption"

echo "Testing with branch name: ${BRANCH_NAME}"
echo "Starts with fix-: $([[ "${BRANCH_NAME}" =~ ^fix- ]] && echo "true" || echo "false")"
echo "Contains syntax: $([[ "${BRANCH_NAME}" == *"syntax"* ]] && echo "true" || echo "false")"

# Test the original condition (with the semicolon issue)
if [[ "${BRANCH_NAME}" =~ ^fix- ]] && { [[ "${BRANCH_NAME}" == *"pattern"* ]] || [[ "${BRANCH_NAME}" == *"regex"* ]] || [[ "${BRANCH_NAME}" == *"trailing-whitespace"* ]] || [[ "${BRANCH_NAME}" == *"formatting"* ]] || [[ "${BRANCH_NAME}" == *"syntax"* ]]; }; then
    echo "Original condition: MATCHED"
else
    echo "Original condition: NOT MATCHED"
fi

# Test the fixed condition
if [[ "${BRANCH_NAME}" =~ ^fix- ]] && { [[ "${BRANCH_NAME}" == *"pattern"* ]] || [[ "${BRANCH_NAME}" == *"regex"* ]] || [[ "${BRANCH_NAME}" == *"trailing-whitespace"* ]] || [[ "${BRANCH_NAME}" == *"formatting"* ]] || [[ "${BRANCH_NAME}" == *"syntax"* ]]; } then
    echo "Fixed condition: MATCHED"
else
    echo "Fixed condition: NOT MATCHED"
fi