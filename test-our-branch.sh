#!/bin/bash

BRANCH_NAME="fix-regex-pattern-matching-bash"
echo "Branch name: ${BRANCH_NAME}"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

echo -e "\n=== Testing with bash regex operator ==="
echo -n "Testing pattern '.*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.*': "
if [[ ${BRANCH_NAME_LOWER} =~ .*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.* ]]; then
  echo "MATCH - ${BASH_REMATCH[0]}"
else
  echo "NO MATCH"
fi

echo -e "\n=== Testing each pattern separately ==="
echo -n "Testing '.*pattern.*': "
if [[ ${BRANCH_NAME_LOWER} =~ .*pattern.* ]]; then
  echo "MATCH - ${BASH_REMATCH[0]}"
else
  echo "NO MATCH"
fi

echo -n "Testing '.*regex.*': "
if [[ ${BRANCH_NAME_LOWER} =~ .*regex.* ]]; then
  echo "MATCH - ${BASH_REMATCH[0]}"
else
  echo "NO MATCH"
fi

echo -e "\n=== Testing with grep ==="
echo -n "Testing with grep -i 'pattern': "
echo "${BRANCH_NAME}" | grep -i "pattern" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -n "Testing with grep -i 'regex': "
echo "${BRANCH_NAME}" | grep -i "regex" > /dev/null && echo "MATCH" || echo "NO MATCH"

echo -e "\n=== Testing with different regex syntax ==="
echo -n "Testing with parentheses: "
if [[ ${BRANCH_NAME_LOWER} =~ (.*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.*) ]]; then
  echo "MATCH - ${BASH_REMATCH[0]}"
else
  echo "NO MATCH"
fi

echo -e "\n=== Testing with a simplified pattern ==="
echo -n "Testing simplified: "
if [[ ${BRANCH_NAME_LOWER} =~ pattern|regex ]]; then
  echo "MATCH - ${BASH_REMATCH[0]}"
else
  echo "NO MATCH"
fi

echo -e "\n=== Testing with a quoted pattern ==="
PATTERN=".*pattern.*|.*regex.*|.*grep.*|.*trailing-whitespace.*|.*formatting.*|.*branch-detection.*"
echo -n "Testing with quoted pattern: "
if [[ ${BRANCH_NAME_LOWER} =~ $PATTERN ]]; then
  echo "MATCH - ${BASH_REMATCH[0]}"
else
  echo "NO MATCH"
fi

echo -e "\n=== Testing with sh shell ==="
echo -n "Testing with sh -c: "
sh -c "BRANCH_NAME=\"fix-regex-pattern-matching-bash\"; BRANCH_NAME_LOWER=\$(echo \"\${BRANCH_NAME}\" | tr '[:upper:]' '[:lower:]'); [[ \${BRANCH_NAME_LOWER} =~ .*pattern.*|.*regex.*|.*grep.* ]] && echo MATCH || echo NO MATCH"
