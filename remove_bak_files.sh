#!/bin/bash
# Script to remove all .bak files from the repository

# Find and remove all .bak files
find . -name "*.bak" -not -path "*/test/fixtures/*" -delete

echo "All .bak files have been removed."
