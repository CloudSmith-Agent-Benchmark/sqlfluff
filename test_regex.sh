#!/bin/bash

# Test script to validate regex pattern matching for branch names

# Test branch names
test_branches=(
  "fix-regex-pattern-matching-1749329471"  # Should match 'regex' and 'pattern'
  "fix-formatting"                         # Should match 'formatting'
  "fix-trailing-whitespace"                # Should match 'trailing-whitespace'
  "fix-branch-detection-issue"             # Should match 'branch-detection'
  "feature-new-functionality"              # Should NOT match any keywords
)

# Function to test a branch name against our regex patterns
test_branch() {
  local branch_name=$1
  local branch_name_lower=$(echo "${branch_name}" | tr '[:upper:]' '[:lower:]')
  
  echo "Testing branch: ${branch_name}"
  
  # Test bash regex pattern
  if [[ ${branch_name_lower} =~ .*(pattern|regex|grep|trailing[-.]whitespace|trailing[-.]spaces|formatting|branch[-.]detection).* ]]; then
    echo "  Bash regex: MATCH - ${BASH_REMATCH[0]}"
    bash_match=true
  else
    echo "  Bash regex: NO MATCH"
    bash_match=false
  fi
  
  # Test grep pattern
  if echo "${branch_name_lower}" | grep -E '(pattern|regex|grep|trailing[-]whitespace|trailing[-]spaces|formatting|branch[-]detection)' > /dev/null; then
    echo "  Grep: MATCH"
    grep_match=true
  else
    echo "  Grep: NO MATCH"
    grep_match=false
  fi
  
  # Combined result
  if $bash_match || $grep_match; then
    echo "  RESULT: Branch contains formatting keywords: YES"
    echo "  ACTION: Would exit with code 0 (success)"
  else
    echo "  RESULT: Branch contains formatting keywords: NO"
    echo "  ACTION: Would continue with normal workflow"
  fi
  echo ""
}

# Run tests
echo "=== Testing Branch Name Pattern Matching ==="
echo ""

for branch in "${test_branches[@]}"; do
  test_branch "$branch"
done

echo "=== Test Complete ==="