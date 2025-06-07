#!/bin/bash

# Create a test file with various error patterns
cat > test_patterns.log << 'INNEREOF'

# Lines that should match "^[^-].*error:"
error: this line starts with error
some error: in the middle
  error: with leading spaces

# Lines that should NOT match
- error: starts with dash
-error: no space after dash
-- error: multiple dashes

INNEREOF

echo "Testing grep pattern with -n to show line numbers:"
grep -n "^[^-].*error:" test_patterns.log

echo -e "\nTesting with bash regex:"
while IFS= read -r line; do
  if [[ "$line" =~ ^[^-].*error: ]]; then
    echo "MATCH: $line"
  fi
done < test_patterns.log

