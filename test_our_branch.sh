#!/bin/bash

# Test with our specific branch name
branch_name="fix-regex-pattern-detection"
branch_name_lower=$(echo "${branch_name}" | tr "[:upper:]" "[:lower:]")

echo "Testing branch: ${branch_name}"

# Test bash regex pattern
echo "Testing bash regex pattern:"
echo "[[ ${branch_name_lower} =~ .*(pattern|regex|grep|trailing[-.]whitespace|trailing[-.]spaces|formatting|branch[-.]detection).* ]]"
if [[ ${branch_name_lower} =~ .*(pattern|regex|grep|trailing[-.]whitespace|trailing[-.]spaces|formatting|branch[-.]detection).* ]]; then
  echo "  Bash regex: MATCH - ${BASH_REMATCH[0]}"
else
  echo "  Bash regex: NO MATCH"
fi

# Test grep pattern
echo "Testing grep pattern:"
echo "echo \"${branch_name_lower}\" | grep -E \"(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)\""
if echo "${branch_name_lower}" | grep -E "(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)" > /dev/null; then
  echo "  Grep: MATCH"
else
  echo "  Grep: NO MATCH"
fi

# Test grep pattern with single quotes
echo "Testing grep pattern with single quotes:"
echo "echo \"${branch_name_lower}\" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)'"
if echo "${branch_name_lower}" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)' > /dev/null; then
  echo "  Grep with single quotes: MATCH"
else
  echo "  Grep with single quotes: NO MATCH"
fi

# Test individual keywords
echo "Testing individual keywords:"
for keyword in "pattern" "regex" "grep" "trailing-whitespace" "trailing-spaces" "formatting" "branch-detection"; do
  if echo "${branch_name_lower}" | grep -i "${keyword}" > /dev/null; then
    echo "  Keyword \"${keyword}\": MATCH"
  else
    echo "  Keyword \"${keyword}\": NO MATCH"
  fi
done
