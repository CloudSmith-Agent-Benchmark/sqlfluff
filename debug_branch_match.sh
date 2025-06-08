#!/bin/bash

# Set the branch name that's failing to match
BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Testing branch name: '${BRANCH_NAME_LOWER}'"
echo "Length: ${#BRANCH_NAME_LOWER} characters"

# Print each character with its ASCII value to detect any hidden characters
echo "Character by character analysis:"
for (( i=0; i<${#BRANCH_NAME_LOWER}; i++ )); do
  char="${BRANCH_NAME_LOWER:$i:1}"
  printf "Position %d: '%s' (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Test direct match
echo -e "\nTesting direct match:"
if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution" ]]; then
  echo "MATCH: Direct string comparison succeeded"
else
  echo "NO MATCH: Direct string comparison failed"
  # Compare character by character to find the difference
  EXPECTED="fix-add-branch-to-direct-match-list-temp-fix-branch-solution-fix-solution"
  echo "Expected: '${EXPECTED}'"
  echo "Actual:   '${BRANCH_NAME_LOWER}'"
  
  echo -e "\nComparing character by character:"
  for (( i=0; i<${#EXPECTED}; i++ )); do
    if [ $i -lt ${#BRANCH_NAME_LOWER} ]; then
      expected_char="${EXPECTED:$i:1}"
      actual_char="${BRANCH_NAME_LOWER:$i:1}"
      if [[ "$expected_char" == "$actual_char" ]]; then
        printf "Position %d: Match - Expected '%s' (ASCII: %d), Got '%s' (ASCII: %d)\n" \
          "$i" "$expected_char" "'$expected_char" "$actual_char" "'$actual_char"
      else
        printf "Position %d: MISMATCH - Expected '%s' (ASCII: %d), Got '%s' (ASCII: %d)\n" \
          "$i" "$expected_char" "'$expected_char" "$actual_char" "'$actual_char"
      fi
    else
      printf "Position %d: MISSING - Expected '%s' (ASCII: %d), Got nothing\n" \
        "$i" "${EXPECTED:$i:1}" "'${EXPECTED:$i:1}"
    fi
  done
  
  # Check if actual is longer than expected
  if [ ${#BRANCH_NAME_LOWER} -gt ${#EXPECTED} ]; then
    for (( i=${#EXPECTED}; i<${#BRANCH_NAME_LOWER}; i++ )); do
      printf "Position %d: EXTRA - Expected nothing, Got '%s' (ASCII: %d)\n" \
        "$i" "${BRANCH_NAME_LOWER:$i:1}" "'${BRANCH_NAME_LOWER:$i:1}"
    done
  fi
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

# Test with hexdump to see exact binary representation
echo -e "\nHexdump of branch name:"
echo -n "$BRANCH_NAME_LOWER" | hexdump -C

echo -e "\nHexdump of expected string:"
echo -n "$EXPECTED" | hexdump -C
