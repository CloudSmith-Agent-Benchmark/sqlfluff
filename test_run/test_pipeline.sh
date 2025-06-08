#!/bin/bash

# Test the original problematic pipeline with set -o pipefail
echo "Test 1: With set -o pipefail and no || true"
set -o pipefail
(exit 1) | tee log.txt
echo "Exit code: $?"

# Test the fixed pipeline with || true
echo -e "\nTest 2: With set -o pipefail and || true"
set -o pipefail
(exit 1) | tee log.txt || true
echo "Exit code: $?"

# Test without set -o pipefail
echo -e "\nTest 3: Without set -o pipefail"
set +o pipefail
(exit 1) | tee log.txt
echo "Exit code: $?"
