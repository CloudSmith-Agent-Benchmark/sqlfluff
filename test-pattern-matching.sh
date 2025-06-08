#!/bin/bash

# Test script for branch name pattern matching

# Test branch names
BRANCH_NAMES=(
  "fix-pattern-matching-improved-v2"
  "fix-whitespace-issues"
  "fix-regex-problems"
  "fix-formatting-errors"
  "feature-new-functionality"
)

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline")

for BRANCH_NAME in "${BRANCH_NAMES[@]}"; do
  echo "=== Testing branch name: ${BRANCH_NAME} ==="
  
  # Convert branch name to lowercase for case-insensitive matching
  BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
  
  # Initialize match tracking
  MATCH_FOUND=false
  MATCHED_KEYWORD=""
  
  # Special case for "pattern" in branch name - direct check
  if [[ "${BRANCH_NAME_LOWER}" == *"pattern"* ]] || [[ "${BRANCH_NAME_LOWER}" =~ pattern ]]; then
    echo "Special case: branch contains 'pattern'"
    MATCHED_KEYWORD="pattern (special case)"
    MATCH_FOUND=true
  fi
  
  # Method 1: Regex pattern matching
  if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "Testing method 1: Regex pattern matching"
    for kw in "${KEYWORDS[@]}"; do
      echo "  Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
      if [[ "${BRANCH_NAME_LOWER}" =~ "${kw}" ]]; then
        echo "  Match found: branch contains keyword '${kw}'"
        MATCHED_KEYWORD="${kw} (regex)"
        MATCH_FOUND=true
        break
      fi
    done
  fi
  
  # Method 2: String contains operator
  if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "Testing method 2: String contains operator"
    for kw in "${KEYWORDS[@]}"; do
      echo "  Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
      if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
        echo "  Match found: branch contains keyword '${kw}'"
        MATCHED_KEYWORD="${kw} (string contains)"
        MATCH_FOUND=true
        break
      fi
    done
  fi
  
  # Method 3: Normalized branch name
  if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "Testing method 3: Normalized branch name"
    NORMALIZED_BRANCH=$(echo "${BRANCH_NAME_LOWER}" | tr -cd 'a-z0-9')
    echo "  Using normalized branch name: ${NORMALIZED_BRANCH}"
    for kw in "${KEYWORDS[@]}"; do
      NORMALIZED_KW=$(echo "${kw}" | tr -cd 'a-z0-9')
      echo "  Checking if normalized '${NORMALIZED_BRANCH}' contains '${NORMALIZED_KW}'"
      if [[ "${NORMALIZED_BRANCH}" =~ "${NORMALIZED_KW}" ]]; then
        echo "  Match found in normalized branch name: contains keyword '${kw}'"
        MATCHED_KEYWORD="${kw} (normalized)"
        MATCH_FOUND=true
        break
      fi
    done
  fi
  
  # Method 4: grep
  if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "Testing method 4: grep"
    for kw in "${KEYWORDS[@]}"; do
      if echo "${BRANCH_NAME_LOWER}" | grep -F -q "${kw}"; then
        echo "  Match found using grep: branch contains keyword '${kw}'"
        MATCHED_KEYWORD="${kw} (grep)"
        MATCH_FOUND=true
        break
      fi
    done
  fi
  
  # Method 5: case statement
  if [[ "$MATCH_FOUND" != "true" ]]; then
    echo "Testing method 5: case statement"
    for kw in "${KEYWORDS[@]}"; do
      case "$BRANCH_NAME_LOWER" in
        *"$kw"*)
          echo "  Match found using case statement: branch contains keyword '${kw}'"
          MATCHED_KEYWORD="${kw} (case)"
          MATCH_FOUND=true
          break
          ;;
      esac
    done
  fi
  
  # Summary
  if [[ "$MATCH_FOUND" == "true" ]]; then
    echo "RESULT: Match found for branch '${BRANCH_NAME}' - matched keyword: ${MATCHED_KEYWORD}"
  else
    echo "RESULT: No match found for branch '${BRANCH_NAME}'"
  fi
  echo ""
done