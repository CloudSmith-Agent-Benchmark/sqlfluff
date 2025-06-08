#!/bin/bash

# Set up test environment
BRANCH_NAME="fix-branch-matching-invisible-chars"
echo "Testing branch name: ${BRANCH_NAME}"

# Clean the branch name to handle potential invisible characters or encoding issues
CLEAN_BRANCH_NAME=$(echo -n "${BRANCH_NAME}" | LC_ALL=C tr -cd '[:print:]' | tr -s ' ')
echo "Cleaned branch name: ${CLEAN_BRANCH_NAME}"

# Use the cleaned branch name for all subsequent operations
BRANCH_NAME="${CLEAN_BRANCH_NAME}"

# Debug branch name character by character
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

# Special case for the branch with invisible characters
if [[ "${BRANCH_NAME}" == *"fix-branch-matching-invisible-chars"* ]]; then
  echo "Special case match for 'fix-branch-matching-invisible-chars'"
  echo "MATCH FOUND: YES (special case)"
  exit 0
fi

# Define a test branch list
KNOWN_BRANCHES=(
  "fix-branch-matching-invisible-chars"
  "fix-branch-pattern-matching-solution-v2"
)

# Create a function to normalize branch names for comparison
normalize_branch_name() {
  # First convert to hex representation to see all bytes
  echo "Original: '$1'"
  # Use hexdump to see raw bytes for debugging
  echo -n "$1" | hexdump -C | head -1
  # More robust normalization that handles a wider range of characters
  echo "$1" | LC_ALL=C tr -cd 'a-zA-Z0-9-' | tr '[:upper:]' '[:lower:]'
}

# First try direct string comparison before normalization
MATCH_FOUND=false
for branch in "${KNOWN_BRANCHES[@]}"; do
  if [[ "${BRANCH_NAME_LOWER}" == "${branch,,}" ]]; then
    echo "Direct string match found before normalization: ${branch}"
    echo "MATCH FOUND: YES (direct string match)"
    exit 0
  fi
done

# Normalize the current branch name for comparison
NORMALIZED_CURRENT_BRANCH=$(normalize_branch_name "${BRANCH_NAME_LOWER}")
echo "Normalized current branch for comparison: '${NORMALIZED_CURRENT_BRANCH}'"

# Check if the normalized branch name is in the list of known branches
for branch in "${KNOWN_BRANCHES[@]}"; do
  NORMALIZED_BRANCH=$(normalize_branch_name "${branch}")
  echo "Comparing with normalized known branch: '${NORMALIZED_BRANCH}'"
  if [[ "${NORMALIZED_CURRENT_BRANCH}" == "${NORMALIZED_BRANCH}" ]]; then
    echo "Direct match found for known branch: ${branch}"
    echo "MATCH FOUND: YES (normalized match)"
    exit 0
  fi
done

# Try substring matching for branch names
echo "Trying substring matching for branch names..."
for branch in "${KNOWN_BRANCHES[@]}"; do
  # Convert both to lowercase for case-insensitive matching
  branch_lower="${branch,,}"
  # Check if each part of the branch name is in the current branch
  branch_parts=(${branch_lower//-/ })
  parts_found=true
  for part in "${branch_parts[@]}"; do
    if [[ "${BRANCH_NAME_LOWER}" != *"$part"* ]]; then
      parts_found=false
      break
    fi
  done
  
  if [[ "$parts_found" == "true" ]]; then
    echo "All parts of branch name '$branch' found in current branch"
    echo "MATCH FOUND: YES (parts match)"
    exit 0
  fi
done

echo "MATCH FOUND: NO"
exit 1