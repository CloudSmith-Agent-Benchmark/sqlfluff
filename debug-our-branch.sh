#!/bin/bash

# Set our branch name
GITHUB_HEAD_REF="fix-pattern-matching-glob-syntax"
GITHUB_REF="refs/heads/fix-pattern-matching-glob-syntax"

# Get the branch name from GitHub environment variables
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: ${BRANCH_NAME}"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Check if we're on a branch specifically fixing formatting issues
echo "Checking if branch name matches formatting fix pattern..."
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
  echo "Branch starts with 'fix-': YES"
  
  # Define keywords to look for
  KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow")
  
  # Debug output for each keyword
  echo -e "\nTesting each keyword individually:"
  for kw in "${KEYWORDS[@]}"; do
    echo -n "Testing for '${kw}': "
    if [[ "${BRANCH_NAME_LOWER}" == *${kw}* ]]; then
      echo "FOUND with glob pattern"
    else
      echo "NOT FOUND with glob pattern"
    fi
    
    echo -n "Testing for '${kw}' with grep: "
    if echo "${BRANCH_NAME_LOWER}" | grep -q "${kw}"; then
      echo "FOUND with grep"
    else
      echo "NOT FOUND with grep"
    fi
  done
  
  # Test with the workflow's pattern matching logic
  echo -e "\nTesting with workflow's pattern matching logic:"
  MATCH_FOUND=false
  for kw in "${KEYWORDS[@]}"; do
    echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
    if [[ "${BRANCH_NAME_LOWER}" == *${kw}* ]]; then
      echo "MATCH FOUND: branch contains keyword '${kw}'"
      MATCH_FOUND=true
      break
    fi
  done
  
  if [[ "$MATCH_FOUND" == "true" ]]; then
    echo "Branch contains formatting keywords: YES"
  else
    echo "Branch contains formatting keywords: NO"
    
    # Try normalized branch name
    NORMALIZED_BRANCH=$(echo "${BRANCH_NAME_LOWER}" | tr -cd 'a-z0-9')
    echo -e "\nNormalized branch name: ${NORMALIZED_BRANCH}"
    for kw in "${KEYWORDS[@]}"; do
      NORMALIZED_KW=$(echo "${kw}" | tr -cd 'a-z0-9')
      echo "Checking if normalized '${NORMALIZED_BRANCH}' contains '${NORMALIZED_KW}'"
      if [[ "${NORMALIZED_BRANCH}" == *${NORMALIZED_KW}* ]]; then
        echo "MATCH FOUND in normalized name: contains keyword '${kw}'"
        MATCH_FOUND=true
        break
      fi
    done
    
    if [[ "$MATCH_FOUND" == "true" ]]; then
      echo "Branch contains formatting keywords (normalized): YES"
    else
      echo "Branch contains formatting keywords (normalized): NO"
    fi
  fi
else
  echo "Branch starts with 'fix-': NO"
fi
