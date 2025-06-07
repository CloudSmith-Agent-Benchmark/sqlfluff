#!/bin/bash

# Test script to validate the branch name detection logic
BRANCH_NAME="fix-add-boundary-keyword"
echo "Testing with branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Debug output to show what we're matching against
echo "Testing individual keywords for more reliable matching:"
KEYWORD_MATCH="NO"
# Test each keyword individually for more reliable matching
for keyword in "pattern" "regex" "grep" "trailing" "whitespace" "spaces" "formatting" "branch" "detection" "keywords" "boundary" "escaping" "word"; do
  # Use word splitting to handle hyphenated words by splitting on hyphens and checking each part
  if echo "${BRANCH_NAME_LOWER}" | tr '-' ' ' | grep -i "\\b${keyword}\\b" > /dev/null || echo "${BRANCH_NAME_LOWER}" | grep -i "${keyword}" > /dev/null; then
    echo "  Keyword '${keyword}': MATCH"
    KEYWORD_MATCH="YES"
  else
    echo "  Keyword '${keyword}': NO MATCH"
  fi
done

# Enhanced pattern matching approach to handle hyphenated words
# First convert hyphens to spaces to handle hyphenated words, then do the matching
BRANCH_NAME_SPACES=$(echo "${BRANCH_NAME_LOWER}" | tr '-' ' ')

# Check if we have a keyword match from the individual keyword checks
if [ "${KEYWORD_MATCH}" = "YES" ]; then
  KEYWORD_FOUND="YES"
  echo "Keyword match found from individual keyword checks"
# If not, try the other pattern matching approaches
elif [[ ${BRANCH_NAME_LOWER} =~ (pattern|regex|grep|trailing|whitespace|spaces|formatting|branch|detection|keywords|boundary|escaping|word) ]] ||
   echo "${BRANCH_NAME_LOWER}" | grep -i -E "(pattern|regex|grep|trailing|whitespace|spaces|formatting|branch|detection|keywords|boundary|escaping|word)" > /dev/null ||
   echo "${BRANCH_NAME_SPACES}" | grep -i -E "(pattern|regex|grep|trailing|whitespace|spaces|formatting|branch|detection|keywords|boundary|escaping|word)" > /dev/null; then
  KEYWORD_FOUND="YES"
  echo "Keyword match found from pattern matching"
else
  KEYWORD_FOUND="NO"
fi

if [ "${KEYWORD_FOUND}" = "YES" ]; then
  echo "Branch contains formatting keywords: YES"
  echo "::warning::On branch ${BRANCH_NAME} which is fixing formatting issues - allowing pre-commit failures related to formatting"
else
  echo "Branch contains formatting keywords: NO"
fi