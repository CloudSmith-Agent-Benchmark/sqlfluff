#!/bin/bash

# Test branch matching logic with the problematic branch name
BRANCH_NAME="fix-workflow-branch-matching-improved"
echo "Testing branch name: ${BRANCH_NAME}"

# Convert branch name to lowercase for case-insensitive matching
BRANCH_NAME_LOWER=$(echo "${BRANCH_NAME}" | tr '[:upper:]' '[:lower:]')
echo "Lowercase branch name: ${BRANCH_NAME_LOWER}"

# Define keywords to look for
KEYWORDS=("pattern" "whitespace" "regex" "grep" "trailing" "spaces" "formatting" "branch" "detection" "newline" "workflow" "temp" "fix" "list" "match" "direct")

echo "Checking if branch starts with 'fix-'..."
if [[ ${BRANCH_NAME} =~ ^fix- ]]; then
    echo "Branch starts with 'fix-': YES"
    
    echo "Checking for keywords in branch name..."
    MATCH_FOUND=false
    MATCHED_KEYWORD=""
    
    # Test each keyword
    for kw in "${KEYWORDS[@]}"; do
        echo "Checking if '${BRANCH_NAME_LOWER}' contains '${kw}'"
        if [[ "${BRANCH_NAME_LOWER}" == *"${kw}"* ]]; then
            echo "Match found: branch contains keyword '${kw}'"
            MATCHED_KEYWORD="${kw}"
            MATCH_FOUND=true
            break
        fi
    done
    
    # Summary of matching results
    if [[ "$MATCH_FOUND" == "true" ]]; then
        echo "RESULT: Match found - branch contains formatting keyword: ${MATCHED_KEYWORD}"
    else
        echo "RESULT: No match found - branch does not contain any formatting keywords"
        
        # Debug: Check each character in the branch name and keyword
        echo "Detailed character-by-character comparison for 'workflow':"
        KEYWORD="workflow"
        echo "Branch name: '${BRANCH_NAME_LOWER}'"
        echo "Keyword: '${KEYWORD}'"
        
        echo "Branch name characters:"
        for (( i=0; i<${#BRANCH_NAME_LOWER}; i++ )); do
            char="${BRANCH_NAME_LOWER:$i:1}"
            printf "Position %d: '%s' (ASCII: %d)\n" "$i" "$char" "'$char"
        done
        
        echo "Keyword characters:"
        for (( i=0; i<${#KEYWORD}; i++ )); do
            char="${KEYWORD:$i:1}"
            printf "Position %d: '%s' (ASCII: %d)\n" "$i" "$char" "'$char"
        done
        
        # Try substring search manually
        for (( i=0; i<${#BRANCH_NAME_LOWER}; i++ )); do
            potential_match=true
            for (( j=0; j<${#KEYWORD} && potential_match; j++ )); do
                if (( i+j >= ${#BRANCH_NAME_LOWER} )) || [[ "${BRANCH_NAME_LOWER:$((i+j)):1}" != "${KEYWORD:$j:1}" ]]; then
                    potential_match=false
                fi
            done
            if [[ "$potential_match" == "true" ]]; then
                echo "Manual match found starting at position $i"
                break
            fi
        done
    fi
else
    echo "Branch does not start with 'fix-'"
fi
