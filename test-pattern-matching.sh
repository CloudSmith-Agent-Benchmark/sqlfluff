#!/bin/bash

# Test the pattern matching logic with our branch name
BRANCH_NAME="fix-workflow-pattern-matching-and-spaces"
echo "Testing with branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")

# Test direct match
echo "Testing direct match..."
if [[ "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-cloudsmith" ||
       "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-workflow-v2" ||
       "${BRANCH_NAME_LOWER}" == "fix-pre-commit-workflow-pattern-matching" ||
       "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-in-workflow" ||
       "${BRANCH_NAME_LOWER}" == "fix-workflow-pattern-matching-and-spaces" ]]; then
    echo "✅ Direct match found!"
else
    echo "❌ Direct match not found"
fi

# Test keyword matching
echo "Testing keyword matching..."
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
    echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
    if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
        echo "✅ Match found: branch contains keyword '${kw}'"
        MATCH_FOUND=true
        break
    fi
done

if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "❌ No keyword match found"
fi

# Test normalized matching
echo "Testing normalized matching..."
NORMALIZED_BRANCH=$(echo "${BRANCH_NAME_LOWER}" | tr -cd 'a-z0-9')
echo "Normalized branch name: ${NORMALIZED_BRANCH}"
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
    NORMALIZED_KW=$(echo "${kw}" | tr -cd 'a-z0-9')
    echo "Checking if normalized '${NORMALIZED_BRANCH}' contains '${NORMALIZED_KW}'"
    if [[ "${NORMALIZED_BRANCH}" == *"${NORMALIZED_KW}"* ]]; then
        echo "✅ Match found in normalized branch name: contains keyword '${kw}'"
        MATCH_FOUND=true
        break
    fi
done

if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "❌ No normalized match found"
fi

# Test grep matching
echo "Testing grep matching..."
MATCH_FOUND=false
for kw in "${KEYWORDS[@]}"; do
    if echo "${BRANCH_NAME_LOWER}" | grep -q -F "${kw}"; then
        echo "✅ Match found using grep: branch contains keyword '${kw}'"
        MATCH_FOUND=true
        break
    fi
done

if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "❌ No grep match found"
fi