#!/bin/bash

# Test with different branch names
test_branch() {
  local branch_name="$1"
  echo "Testing branch: '$branch_name'"
  
  # Debug branch name character by character
  echo "Branch name character by character:"
  for (( i=0; i<${#branch_name}; i++ )); do
    char="${branch_name:$i:1}"
    printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
  done
  
  # Test the condition
  if [[ "$branch_name" == fix-* ]]; then
    echo "Branch starts with 'fix-': YES"
  else
    echo "Branch starts with 'fix-': NO"
  fi
  
  # Try with explicit string
  if [[ "$branch_name" == "fix-"* ]]; then
    echo "Branch starts with 'fix-' (quoted): YES"
  else
    echo "Branch starts with 'fix-' (quoted): NO"
  fi
  
  # Try with regex
  if [[ "$branch_name" =~ ^fix- ]]; then
    echo "Branch starts with 'fix-' (regex): YES"
  else
    echo "Branch starts with 'fix-' (regex): NO"
  fi
  
  echo "-----------------------------------"
}

# Test with current branch name
current_branch=$(git branch --show-current)
test_branch "$current_branch"

# Test with explicit branch name
test_branch "fix-conditional-logic"

# Test with a branch name that has potential invisible characters
test_branch $'\u200Bfix-conditional-logic'  # Zero-width space prefix
