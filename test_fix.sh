#!/bin/bash

BRANCH_NAME="fix-add-keywords-to-detection"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing with branch name: ${BRANCH_NAME}"
echo "Testing individual keywords for more reliable matching:"
KEYWORD_MATCH="NO"

# Test each keyword individually for more reliable matching
for keyword in "pattern" "regex" "grep" "trailing" "whitespace" "spaces" "formatting" "branch" "detection" "keywords"; do
  # Use word splitting to handle hyphenated words by splitting on hyphens and checking each part
  if echo "${BRANCH_NAME_LOWER}" | tr '-' ' ' | grep -i "\\b${keyword}\\b" > /dev/null || echo "${BRANCH_NAME_LOWER}" | grep -i "${keyword}" > /dev/null; then
    echo "  Keyword '${keyword}': MATCH"
    KEYWORD_MATCH="YES"
  else
    echo "  Keyword '${keyword}': NO MATCH"
  fi
done

echo "KEYWORD_MATCH value: ${KEYWORD_MATCH}"

# For comparison, test with the old pattern (single backslash)
echo -e "\nTesting with old pattern (single backslash):"
for keyword in "pattern" "regex" "grep" "trailing" "whitespace" "spaces" "formatting" "branch" "detection" "keywords"; do
  if echo "${BRANCH_NAME_LOWER}" | tr '-' ' ' | grep -i "\b${keyword}\b" > /dev/null || echo "${BRANCH_NAME_LOWER}" | grep -i "${keyword}" > /dev/null; then
    echo "  Keyword '${keyword}': MATCH"
  else
    echo "  Keyword '${keyword}': NO MATCH"
  fi
done