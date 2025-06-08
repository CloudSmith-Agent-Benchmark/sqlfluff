#!/bin/bash

# Test script to validate the branch matching logic

# Test branch names
BRANCH_NAMES=(
  "fix-add-branch-to-direct-match-list-v3-solution-temp-fix-solution"
  "fix-add-branch-to-direct-match-list-v3-solution-temp-fix-solution "  # with trailing space
  " fix-add-branch-to-direct-match-list-v3-solution-temp-fix-solution"  # with leading space
  "fix-add-branch-to-direct-match-list-v3-solution-temp-fix-solution\r" # with carriage return
  "fix-branch-matching-wildcard-solution"
)

for BRANCH_NAME in "${BRANCH_NAMES[@]}"; do
  echo "Testing branch: '$BRANCH_NAME'"
  
  # Convert branch name to lowercase
  BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
  
  # Debug output for hex representation
  echo "Branch name hex representation:"
  echo "${BRANCH_NAME}" | hexdump -C
  
  # Normalize branch name
  CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME_LOWER}" | tr -d '[:cntrl:]' | xargs)
  echo "Cleaned branch name: '$CLEAN_BRANCH_NAME'"
  
  # Test the matching logic for both patterns
  if [[ "${CLEAN_BRANCH_NAME}" == "fix-add-branch-to-direct-match-list-v3-solution-temp-fix-solution"* ]]; then
    echo "✅ MATCH FOUND: Branch matches the first pattern"
  else
    echo "❌ NO MATCH: Branch does not match the first pattern"
  fi
  
  if [[ "${CLEAN_BRANCH_NAME}" == "fix-branch-matching-wildcard-solution"* ]]; then
    echo "✅ MATCH FOUND: Branch matches the second pattern"
  else
    echo "❌ NO MATCH: Branch does not match the second pattern"
  fi
  
  echo "-----------------------------------"
done
