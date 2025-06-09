#!/bin/bash

# Debug script to test the grep pattern matching issue with different shell environments
BRANCH_NAME="fix-add-grep-to-workflow-keywords"

echo "=== Testing with different shell environments and quoting styles ==="
echo "Branch name: ${BRANCH_NAME}"

echo -e "\n=== 1. Testing with direct grep command ==="
echo -n "grep -i grep: "
echo "${BRANCH_NAME}" | grep -i grep > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 2. Testing with grep -E and parentheses ==="
echo -n "grep -iE '(grep)': "
echo "${BRANCH_NAME}" | grep -iE '(grep)' > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 3. Testing with grep -E and multiple patterns with single quotes ==="
echo -n "grep -iE '(pattern|regex|grep)': "
echo "${BRANCH_NAME}" | grep -iE '(pattern|regex|grep)' > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 4. Testing with grep -E and multiple patterns with double quotes ==="
echo -n "grep -iE \"(pattern|regex|grep)\": "
echo "${BRANCH_NAME}" | grep -iE "(pattern|regex|grep)" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 6. Testing with grep -E and escaped parentheses ==="
echo -n "grep -iE \"\(pattern|regex|grep\)\": "
echo "${BRANCH_NAME}" | grep -iE "\(pattern|regex|grep\)" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 7. Testing with full pattern from workflow ==="
echo -n "grep -iE \"(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)\": "
echo "${BRANCH_NAME}" | grep -iE "(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 8. Testing with bash regex ==="
echo -n "bash regex [[ =~ ]]: "
if [[ ${BRANCH_NAME} =~ (pattern|regex|grep|trailing-whitespace|formatting|branch-detection) ]]; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -e "\n=== 9. Testing with bash regex and word boundaries ==="
echo -n "bash regex with word boundaries: "
if [[ ${BRANCH_NAME} =~ \<(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)\> ]]; then
  echo "MATCH"
else
  echo "NO MATCH"
fi

echo -e "\n=== 10. Testing with sh -c to simulate GitHub Actions environment ==="
echo -n "sh -c 'echo \"${BRANCH_NAME}\" | grep -iE \"(pattern|regex|grep)\"': "
sh -c "echo \"${BRANCH_NAME}\" | grep -iE \"(pattern|regex|grep)\"" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 11. Testing with sh -c and single quotes ==="
echo -n "sh -c with single quotes: "
sh -c 'echo "fix-add-grep-to-workflow-keywords" | grep -iE "(pattern|regex|grep)"' > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 12. Testing with sh -c and variable expansion ==="
PATTERN="(pattern|regex|grep|trailing-whitespace|formatting|branch-detection)"
echo -n "sh -c with variable expansion: "
sh -c "echo \"${BRANCH_NAME}\" | grep -iE \"${PATTERN}\"" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== 13. Testing with dash shell ==="
echo -n "dash -c: "
dash -c "echo \"${BRANCH_NAME}\" | grep -iE \"(pattern|regex|grep)\"" > /dev/null && echo "MATCH" || echo "NO MATCH"

