#!/bin/bash

echo "Bash version: $BASH_VERSION"
echo "Shell: $SHELL"
echo "LC_ALL: $LC_ALL"
echo "LANG: $LANG"
echo "LC_CTYPE: $LC_CTYPE"

# Test with different locales
echo "Testing with different locales:"

# Default locale
echo "Default locale:"
CLEAN_BRANCH_NAME=$(echo "​fix-invisible-chars" | tr -dc "[:graph:][:space:]")
echo "Clean branch name: '$CLEAN_BRANCH_NAME'"
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
else
  echo "Branch starts with 'fix-': NO"
fi

# C locale
echo "C locale:"
CLEAN_BRANCH_NAME=$(echo "​fix-invisible-chars" | LC_ALL=C tr -dc "[:graph:][:space:]")
echo "Clean branch name: '$CLEAN_BRANCH_NAME'"
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
else
  echo "Branch starts with 'fix-': NO"
fi

# POSIX locale
echo "POSIX locale:"
CLEAN_BRANCH_NAME=$(echo "​fix-invisible-chars" | LC_ALL=POSIX tr -dc "[:graph:][:space:]")
echo "Clean branch name: '$CLEAN_BRANCH_NAME'"
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
else
  echo "Branch starts with 'fix-': NO"
fi

# Try with sed instead of tr
echo "Using sed instead of tr:"
CLEAN_BRANCH_NAME=$(echo "​fix-invisible-chars" | LC_ALL=C sed 's/[^[:graph:][:space:]]//g')
echo "Clean branch name: '$CLEAN_BRANCH_NAME'"
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
else
  echo "Branch starts with 'fix-': NO"
fi
