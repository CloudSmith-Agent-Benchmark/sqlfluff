#!/bin/bash

# Test the specific branch name from the logs
BRANCH_NAME="fix-invisible-chars"
echo "Testing branch: '$BRANCH_NAME'"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Test with different comparison methods
echo "Testing with different comparison methods:"

# Method 1: Direct string comparison
if [[ "${BRANCH_NAME}" == fix-* ]]; then
  echo "Method 1 (direct): Branch starts with 'fix-': YES"
else
  echo "Method 1 (direct): Branch starts with 'fix-': NO"
fi

# Method 2: Quoted pattern
if [[ "${BRANCH_NAME}" == "fix-"* ]]; then
  echo "Method 2 (quoted pattern): Branch starts with 'fix-': YES"
else
  echo "Method 2 (quoted pattern): Branch starts with 'fix-': NO"
fi

# Method 3: Regex comparison
if [[ "${BRANCH_NAME}" =~ ^fix- ]]; then
  echo "Method 3 (regex): Branch starts with 'fix-': YES"
else
  echo "Method 3 (regex): Branch starts with 'fix-': NO"
fi

# Method 4: Using grep
if echo "${BRANCH_NAME}" | grep -q "^fix-"; then
  echo "Method 4 (grep): Branch starts with 'fix-': YES"
else
  echo "Method 4 (grep): Branch starts with 'fix-': NO"
fi

# Method 5: Using substring
if [ "${BRANCH_NAME:0:4}" = "fix-" ]; then
  echo "Method 5 (substring): Branch starts with 'fix-': YES"
else
  echo "Method 5 (substring): Branch starts with 'fix-': NO"
fi

# Method 6: Clean the branch name and then check
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | LC_ALL=C tr -dc "[:graph:][:space:]")
echo "Clean branch name: '$CLEAN_BRANCH_NAME'"

if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Method 6 (clean): Branch starts with 'fix-': YES"
else
  echo "Method 6 (clean): Branch starts with 'fix-': NO"
fi

# Method 7: Check for invisible characters
if [[ $(echo -n "${BRANCH_NAME}" | hexdump -C | head -1) =~ ^00000000 ]]; then
  echo "Method 7: No invisible characters at the start"
else
  echo "Method 7: Possible invisible characters at the start"
fi

# Method 8: Hexdump the entire string
echo "Hexdump of branch name:"
echo -n "${BRANCH_NAME}" | hexdump -C
