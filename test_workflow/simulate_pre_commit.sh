#!/bin/bash
# Simulate pre-commit run that would modify files
echo "black....................................................................Failed"
echo "- hook id: black"
echo "- files were modified by this hook"
echo ""
echo "All done! ✨ 🍰 ✨"
echo "388 files would be left unchanged."
echo ""
echo "mypy.....................................................................Failed"
echo "- hook id: mypy"
echo "- files were modified by this hook"
echo ""
echo "Success: no issues found in 247 source files"
exit 1
