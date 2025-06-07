#!/bin/bash

# Create a test log file with ANSI color codes
echo -e "\033[2m- hook id: black\033[m" > test.log
echo -e "\033[2m- files were modified by this hook\033[m" >> test.log
echo -e "\033[1mAll done! ✨ 🍰 ✨\033[0m" >> test.log

echo "Original log file content:"
cat test.log

echo -e "\nTesting original sed command:"
cat test.log | sed 's/\x1b\[[0-9;]*m//g' | grep -c "files were modified by this hook"

echo -e "\nTesting new sed command:"
cat test.log | sed -E "s/\x1B\[([0-9]{1,3}(;[0-9]{1,3})*)?[mGK]//g" | grep -c "files were modified by this hook"

# Clean up
rm test.log