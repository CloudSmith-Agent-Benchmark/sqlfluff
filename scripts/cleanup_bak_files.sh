#!/bin/bash
# Script to clean up .bak files before running pre-commit hooks

echo "Cleaning up .bak files..."
find . -name "*.bak" -type f -delete
echo "Cleanup complete."