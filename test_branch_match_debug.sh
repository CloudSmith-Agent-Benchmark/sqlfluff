#!/bin/bash

# Set the branch name to the one that's failing
BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-fix"
echo "Testing branch name: $BRANCH_NAME"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: $BRANCH_NAME_LOWER"

# Debug: print each character with its ASCII value
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME_LOWER}; i++ )); do
  char="${BRANCH_NAME_LOWER:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Test direct match
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix" ]]; then
  echo "DIRECT MATCH SUCCESSFUL"
else
  echo "DIRECT MATCH FAILED"
  
  # Compare character by character with the expected string
  EXPECTED="fix-add-branch-to-direct-match-list-temp-fix"
  echo "Comparing with expected string character by character:"
  for (( i=0; i<${#EXPECTED}; i++ )); do
    expected_char="${EXPECTED:$i:1}"
    actual_char="${BRANCH_NAME_LOWER:$i:1}"
    if [[ "$expected_char" != "$actual_char" ]]; then
      printf "Mismatch at position %d: expected '%s' (ASCII: %d), got '%s' (ASCII: %d)\n" \
        "$i" "$expected_char" "'$expected_char" "$actual_char" "'$actual_char"
    fi
  done
  
  # Check if there are any hidden characters
  if [[ ${#BRANCH_NAME_LOWER} != ${#EXPECTED} ]]; then
    echo "Length mismatch: expected ${#EXPECTED}, got ${#BRANCH_NAME_LOWER}"
  fi
fi

# Test with hexdump to see if there are any hidden characters
echo "Hexdump of branch name:"
echo -n "$BRANCH_NAME_LOWER" | hexdump -C

echo "Hexdump of expected string:"
echo -n "fix-add-branch-to-direct-match-list-temp-fix" | hexdump -C
