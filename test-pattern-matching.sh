#!/bin/bash

# Test script to verify our pattern matching solution works correctly
# This simulates the branch name detection logic in the GitHub Actions workflow

# Test cases
TEST_BRANCHES=(
  "fix-pattern-matching-and-whitespace-improved"
  "fix-formatting-issues"
  "fix-branch-detection"
  "feature-new-functionality"
  "bugfix-unrelated"
)

for BRANCH_NAME in "${TEST_BRANCHES[@]}"; do
  echo "========================================"
  echo "Testing branch name: $BRANCH_NAME"
  echo "========================================"
  
  # Convert to lowercase
  BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
  
  # Define keywords to look for
  KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection")
  echo "Checking branch name '${BRANCH_NAME_LOWER}' for keywords..."
  MATCH_FOUND=false
  MATCHED_KEYWORD=""
  
  # Use bash's native string operations
  for kw in "${KEYWORDS[@]}"; do
    if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
      echo "Match found: branch contains keyword '${kw}'"
      MATCHED_KEYWORD="${kw}"
      MATCH_FOUND=true
      break
    fi
  done
  
  # Fallback check with normalized branch name
  if [[ "$MATCH_FOUND" != "true" ]]; then
    NORMALIZED_BRANCH=$(echo "${BRANCH_NAME_LOWER}" | tr -cd 'a-z0-9')
    echo "Using normalized branch name for fallback check: ${NORMALIZED_BRANCH}"
    
    for kw in "${KEYWORDS[@]}"; do
      NORMALIZED_KW=$(echo "${kw}" | tr -cd 'a-z0-9')
      if [[ "${NORMALIZED_BRANCH}" == *"${NORMALIZED_KW}"* ]]; then
        echo "Match found in normalized branch name: contains keyword '${kw}'"
        MATCHED_KEYWORD="${kw} (normalized)"
        MATCH_FOUND=true
        break
      fi
    done
  fi
  
  # Output result
  if [[ "$MATCH_FOUND" == "true" ]]; then
    echo "RESULT: Branch contains formatting keywords: YES (matched: ${MATCHED_KEYWORD})"
  else
    echo "RESULT: Branch contains formatting keywords: NO"
  fi
  echo ""
done