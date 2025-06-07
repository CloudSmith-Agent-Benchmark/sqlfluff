#!/bin/bash

# Simulate GitHub Actions environment
BRANCH_NAME="fix-regex-pattern-detection"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

echo "Branch name: ${BRANCH_NAME}"
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

echo -e "\n=== Testing bash regex pattern match ==="
if [[ ${BRANCH_NAME_LOWER} =~ .*(pattern|regex|grep|trailing[-.]whitespace|trailing[-.]spaces|formatting|branch[-.]detection).* ]]; then
  echo "Match found: ${BASH_REMATCH[0]}"
else
  echo "No match found with bash regex"
fi

echo -e "\n=== Testing grep pattern match ==="
if echo "${BRANCH_NAME_LOWER}" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)' > /dev/null; then
  echo "Match found using grep"
else
  echo "No match found with grep"
fi

echo -e "\n=== Testing combined approach ==="
if [[ ${BRANCH_NAME_LOWER} =~ .*(pattern|regex|grep|trailing[-.]whitespace|trailing[-.]spaces|formatting|branch[-.]detection).* ]] || \
   echo "${BRANCH_NAME_LOWER}" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)' > /dev/null; then
  echo "Branch contains formatting keywords: YES"
else
  echo "Branch contains formatting keywords: NO"
fi

echo -e "\n=== Testing individual keywords ==="
for keyword in "pattern" "regex" "grep" "trailing-whitespace" "trailing-spaces" "formatting" "branch-detection"; do
  if echo "${BRANCH_NAME_LOWER}" | grep -i "${keyword}" > /dev/null; then
    echo "Keyword '${keyword}': MATCH"
  else
    echo "Keyword '${keyword}': NO MATCH"
  fi
done

echo -e "\n=== Testing with different quoting styles ==="
# Test with single quotes
if echo "${BRANCH_NAME_LOWER}" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)' > /dev/null; then
  echo "Single quotes: MATCH"
else
  echo "Single quotes: NO MATCH"
fi

# Test with double quotes
if echo "${BRANCH_NAME_LOWER}" | grep -E "(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)" > /dev/null; then
  echo "Double quotes: MATCH"
else
  echo "Double quotes: NO MATCH"
fi

# Test with escaped parentheses
if echo "${BRANCH_NAME_LOWER}" | grep -E "\(pattern\|regex\|grep\|trailing[-]whitespace\|trailing[-]spaces\|formatting\|branch[-]detection\)" > /dev/null; then
  echo "Escaped parentheses: MATCH"
else
  echo "Escaped parentheses: NO MATCH"
fi

echo -e "\n=== Testing with sh -c to simulate GitHub Actions environment ==="
if sh -c "echo \"${BRANCH_NAME_LOWER}\" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)'" > /dev/null; then
  echo "sh -c with single quotes: MATCH"
else
  echo "sh -c with single quotes: NO MATCH"
fi

if sh -c "echo \"${BRANCH_NAME_LOWER}\" | grep -E \"(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)\"" > /dev/null; then
  echo "sh -c with double quotes: MATCH"
else
  echo "sh -c with double quotes: NO MATCH"
fi
