#!/bin/bash

BRANCH_NAME="fix-add-branch-to-direct-match-list-temp-branch"
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')

if [[ "${BRANCH_NAME_LOWER}" == "fix-add-branch-to-direct-match-list-temp-branch" ]]; then
  echo "Direct match found for branch: ${BRANCH_NAME_LOWER}"
  exit 0
else
  echo "No direct match found for branch: ${BRANCH_NAME_LOWER}"
  exit 1
fi
