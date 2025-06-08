#!/bin/bash

# Simulate the GitHub Actions environment
export GITHUB_REF="refs/heads/fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
export GITHUB_HEAD_REF=""
export RAW_LOG="pre-commit.log"

echo "Simulating GitHub Actions workflow with branch: ${GITHUB_REF}"

# Extract branch name as done in the workflow
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Extracted branch name: '${BRANCH_NAME}'"

# Convert to lowercase
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: '${BRANCH_NAME_LOWER}'"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Test the direct match condition from the workflow
echo -e "\nTesting direct match condition:"
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
  echo "MATCH: Direct string comparison succeeded"
  MATCH_FOUND=true
  MATCHED_KEYWORD="direct match"
else
  echo "NO MATCH: Direct string comparison failed"
  MATCH_FOUND=false
  
  # Compare the strings character by character
  EXPECTED="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
  echo "Expected: '${EXPECTED}'"
  echo "Actual:   '${BRANCH_NAME_LOWER}'"
  
  if [ ${#BRANCH_NAME_LOWER} -ne ${#EXPECTED} ]; then
    echo "Length mismatch: Expected ${#EXPECTED}, got ${#BRANCH_NAME_LOWER}"
  fi
  
  # Find the first difference
  for (( i=0; i<${#EXPECTED} && i<${#BRANCH_NAME_LOWER}; i++ )); do
    if [[ "${EXPECTED:$i:1}" != "${BRANCH_NAME_LOWER:$i:1}" ]]; then
      echo "First difference at position $i:"
      echo "Expected: '${EXPECTED:$i:1}' (ASCII: '${EXPECTED:$i:1})"
      echo "Actual:   '${BRANCH_NAME_LOWER:$i:1}' (ASCII: '${BRANCH_NAME_LOWER:$i:1})"
      break
    fi
  done
fi

# Test with printf to ensure no hidden characters
echo -e "\nTesting with printf for exact string comparison:"
EXPECTED="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
PRINTF_BRANCH=$(printf "%s" "$BRANCH_NAME_LOWER")
if [[ "$PRINTF_BRANCH" == "$EXPECTED" ]]; then
  echo "MATCH: Printf comparison succeeded"
else
  echo "NO MATCH: Printf comparison failed"
fi

# Test with hexdump
echo -e "\nHexdump comparison:"
echo "Branch name hexdump:"
echo -n "$BRANCH_NAME_LOWER" | hexdump -C
echo "Expected hexdump:"
echo -n "$EXPECTED" | hexdump -C

# Test with a different comparison method
echo -e "\nTesting with different comparison method:"
if [ "$BRANCH_NAME_LOWER" = "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]; then
  echo "MATCH: Single bracket comparison succeeded"
else
  echo "NO MATCH: Single bracket comparison failed"
fi

# Test with grep
echo -e "\nTesting with grep:"
if echo "$BRANCH_NAME_LOWER" | grep -q -F "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"; then
  echo "MATCH: Grep comparison succeeded"
else
  echo "NO MATCH: Grep comparison failed"
fi

# Test with case statement
echo -e "\nTesting with case statement:"
case "$BRANCH_NAME_LOWER" in
  "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution")
    echo "MATCH: Case statement comparison succeeded"
    ;;
  *)
    echo "NO MATCH: Case statement comparison failed"
    ;;
esac

# Test with a variable comparison
echo -e "\nTesting with variable comparison:"
COMPARE_STRING="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
if [[ "$BRANCH_NAME_LOWER" == "$COMPARE_STRING" ]]; then
  echo "MATCH: Variable comparison succeeded"
else
  echo "NO MATCH: Variable comparison failed"
fi

# Test with a simplified version of the workflow's if statement
echo -e "\nTesting with simplified workflow if statement:"
if [[ "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-cloudsmith" ||
     "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
  echo "MATCH: Simplified if statement succeeded"
else
  echo "NO MATCH: Simplified if statement failed"
fi

# Test with a different branch name to verify the comparison logic works
echo -e "\nTesting with a different branch name:"
TEST_BRANCH="fix-regex-pattern-matching-cloudsmith"
if [[ "$TEST_BRANCH" == "fix-regex-pattern-matching-cloudsmith" ]]; then
  echo "MATCH: Different branch comparison succeeded"
else
  echo "NO MATCH: Different branch comparison failed"
fi
