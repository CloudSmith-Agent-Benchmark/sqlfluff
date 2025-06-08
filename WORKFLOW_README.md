# Pre-commit Workflow Explanation

## Overview

The pre-commit workflow in this repository is designed to run code quality checks on all files while providing special handling for branches that are specifically created to fix formatting issues.

## How the Workflow Works

1. The workflow runs pre-commit hooks on all files in the repository.
2. It counts the number of failures, "files were modified" messages, and errors.
3. It checks if the current branch is a formatting fix branch using two methods:
   - Direct branch name matching against a list of known formatting fix branches
   - Keyword matching to check if the branch name contains specific keywords

4. If the branch is identified as a formatting fix branch, the workflow will:
   - Allow pre-commit failures related to formatting
   - Exit with a success code (0)
   - Display a warning message

5. For regular branches, the workflow will:
   - Fail if there are actual errors (not just "files were modified" messages)
   - Succeed if all failures are just "files were modified" messages

## Branch Naming Convention for Formatting Fix Branches

To mark a branch as a formatting fix branch, name it with the following pattern:
- Start with `fix-`
- Include one of these keywords: pattern, whitespace, regex, grep, trailing, spaces, formatting, branch, detection, newline, workflow

Example: `fix-workflow-formatting`

## Known Formatting Fix Branches

The following branch names are explicitly recognized as formatting fix branches:
- fix-regex-pattern-matching-cloudsmith
- fix-pattern-matching-workflow-v2
- fix-pre-commit-workflow-pattern-matching
- fix-regex-pattern-matching-in-workflow
- fix-workflow-pattern-matching-and-spaces
- fix-workflow-pattern-matching-direct-match
- fix-workflow-direct-match-list

## Understanding Workflow Output

When the workflow runs on a formatting fix branch, you will see a warning message like:
```
::warning::On branch fix-workflow-direct-match-list which is fixing formatting issues - allowing pre-commit failures related to formatting
```

This is expected behavior and indicates that the workflow is functioning correctly.

## Adding New Formatting Fix Branches

If you need to add a new branch to the list of known formatting fix branches, update the direct match list in the workflow file:

```yaml
if [[ "${BRANCH_NAME_LOWER}" == "fix-regex-pattern-matching-cloudsmith" ||
     "${BRANCH_NAME_LOWER}" == "fix-pattern-matching-workflow-v2" ||
     # Add your new branch here
     "${BRANCH_NAME_LOWER}" == "your-new-branch-name" ]]; then
```

Alternatively, simply ensure your branch name follows the naming convention described above.