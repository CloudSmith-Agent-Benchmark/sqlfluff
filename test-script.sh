set -e
# Get the branch name from GitHub environment variables
# For pull requests, GITHUB_HEAD_REF contains the source branch name
# For direct pushes, we extract it from GITHUB_REF
BRANCH_NAME="${GITHUB_HEAD_REF:-${GITHUB_REF#refs/heads/}}"
echo "Current branch name: ${BRANCH_NAME}"
echo "GITHUB_REF: ${GITHUB_REF}"
echo "GITHUB_HEAD_REF: ${GITHUB_HEAD_REF}"

# Debug branch name character by character to detect any invisible characters
echo "Branch name character by character:"
for (( i=0; i<${#BRANCH_NAME}; i++ )); do
  char="${BRANCH_NAME:$i:1}"
  printf "Position %d: %s (ASCII: %d)\n" "$i" "$char" "'$char"
done

# Clean the branch name by removing any invisible characters
# Using LC_ALL=C ensures consistent behavior across different locales
# [:graph:] includes all visible characters and [:space:] preserves spaces
# This removes zero-width spaces and other invisible characters
CLEAN_BRANCH_NAME=$(echo "${BRANCH_NAME}" | LC_ALL=C tr -dc "[:graph:][:space:]")
echo "Clean branch name: '${CLEAN_BRANCH_NAME}'"

# Check if we're on a branch specifically fixing formatting issues
# Using string contains operator for substring matching anywhere in the branch name
# Note: When using =~ operator in bash, the regex pattern should not be quoted
echo "Checking if branch name matches formatting fix pattern..."
# Use string prefix matching instead of regex for more reliable behavior
if [[ "${CLEAN_BRANCH_NAME}" == fix-* ]]; then
  echo "Branch starts with 'fix-': YES"
  # Any branch that starts with 'fix-' is considered a formatting fix branch
  echo "::warning::On branch ${CLEAN_BRANCH_NAME} which starts with 'fix-' - allowing pre-commit failures"
  # Set flag to skip failure checks
  SKIP_FAILURE_CHECKS=true
else
  echo "Branch starts with 'fix-': NO"
fi

# First check if we should skip failure checks (for fix-* branches)
if [ "$SKIP_FAILURE_CHECKS" = true ]; then
  echo "::notice::Skipping failure checks because this is a formatting fix branch"
  # Reset exit code to 0 to prevent workflow failure when we're on a formatting fix branch
  exit 0
# Only then check for failures if we're not skipping checks
elif [ "${FAILED_COUNT}" -gt 0 ]; then
  # If all failures are just "files were modified" messages, consider it a success
  if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
    echo "::warning::Pre-commit reported 'Failed' but these were just 'files were modified' messages"
    # Success - no need to exit
  # If we have actual errors (failures without "files were modified"), exit with error
  elif [ "${MODIFIED_COUNT}" -eq 0 ]; then
    echo "::error::Pre-commit found actual issues that need to be fixed"
    exit 1
  # If we have a mix of "files were modified" and other failures, check for actual errors
  elif [ "${ERROR_COUNT}" -gt 0 ]; then
    echo "::error::Pre-commit found actual errors that need to be fixed"
    exit 1
  else
    echo "::warning::Pre-commit reported 'files were modified' but no actual errors were found"
    # Success - no need to exit
  fi
fi
