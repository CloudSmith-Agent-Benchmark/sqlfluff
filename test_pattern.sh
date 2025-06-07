#!/bin/bash
BRANCH_NAME="fix-pattern-matching-bash"
echo "Branch name: $BRANCH_NAME"
echo "Contains 'pattern' (using ==): $([[ "$BRANCH_NAME" == *pattern* ]] && echo "true" || echo "false")"
echo "Contains 'pattern' (using =~): $([[ "$BRANCH_NAME" =~ pattern ]] && echo "true" || echo "false")"
