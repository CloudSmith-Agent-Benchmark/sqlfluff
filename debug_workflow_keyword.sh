#!/bin/bash

BRANCH_NAME="fix-workflow-branch-matching-improved"
KEYWORD="workflow"

echo "Testing if branch '${BRANCH_NAME}' contains keyword '${KEYWORD}'"

# Direct bash string contains test
if [[ "${BRANCH_NAME}" == *"${KEYWORD}"* ]]; then
    echo "Direct bash test: MATCH FOUND"
else
    echo "Direct bash test: NO MATCH"
fi

# Using grep
if echo "${BRANCH_NAME}" | grep -q "${KEYWORD}"; then
    echo "Grep test: MATCH FOUND"
else
    echo "Grep test: NO MATCH"
fi

# Character by character comparison
echo "Searching for '${KEYWORD}' in '${BRANCH_NAME}' character by character:"
found=false
for (( i=0; i<=${#BRANCH_NAME}-${#KEYWORD}; i++ )); do
    substring="${BRANCH_NAME:$i:${#KEYWORD}}"
    if [[ "$substring" == "$KEYWORD" ]]; then
        echo "Match found at position $i: '$substring'"
        found=true
        break
    fi
done

if [[ "$found" != "true" ]]; then
    echo "No match found in character-by-character search"
fi
