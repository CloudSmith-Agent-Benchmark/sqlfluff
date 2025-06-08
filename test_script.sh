#!/bin/bash
set -e

# Create a test log file
cat > test_pre-commit.log << 'EOL'
black....................................................................Failed
- hook id: black
- files were modified by this hook

All done! ✨ 🍰 ✨
388 files would be left unchanged.

mypy.....................................................................Failed
- hook id: mypy
- files were modified by this hook

Success: no issues found in 247 source files

flake8...................................................................Failed
- hook id: flake8
- files were modified by this hook
doc8.....................................................................Failed
- hook id: doc8
- files were modified by this hook

Scanning...
Validating...
========
Total files scanned = 0
Total files ignored = 43
Total accumulated errors = 0

yamllint.................................................................Failed
- hook id: yamllint
- files were modified by this hook
ruff.....................................................................Failed
- hook id: ruff
- files were modified by this hook
codespell................................................................Failed
- hook id: codespell
- files were modified by this hook
EOL

# Count the failures and modified messages
FAILED_COUNT=$(grep -c "Failed" test_pre-commit.log || echo 0)
MODIFIED_COUNT=$(grep -c "files were modified by this hook" test_pre-commit.log || echo 0)
ERROR_COUNT=$(grep -c "^[^-].*error:" test_pre-commit.log || echo 0)

echo "Found ${FAILED_COUNT} failures, ${MODIFIED_COUNT} 'files were modified' messages, and ${ERROR_COUNT} errors"

# Check the condition
if [ "${FAILED_COUNT}" -eq "${MODIFIED_COUNT}" ]; then
  echo "CONDITION MET: All failures are just 'files were modified' messages"
else
  echo "CONDITION NOT MET: Not all failures are 'files were modified' messages"
  echo "FAILED_COUNT=${FAILED_COUNT}, MODIFIED_COUNT=${MODIFIED_COUNT}"
fi

# Debug the values
echo "Debug values:"
echo "FAILED_COUNT=${FAILED_COUNT}"
echo "MODIFIED_COUNT=${MODIFIED_COUNT}"
echo "ERROR_COUNT=${ERROR_COUNT}"
