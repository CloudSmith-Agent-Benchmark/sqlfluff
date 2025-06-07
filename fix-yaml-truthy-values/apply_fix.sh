#!/bin/bash

# Make a backup of the original file
cp ../test/fixtures/rules/std_rule_cases/RF02.yml ../test/fixtures/rules/std_rule_cases/RF02.yml.bak

# Copy the fixed file to the correct location
cp RF02.yml ../test/fixtures/rules/std_rule_cases/RF02.yml

echo "Fix applied successfully!"