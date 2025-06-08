#!/bin/bash
# Script to help set up and run act for local workflow validation

# Check if act is installed
if ! command -v act &> /dev/null; then
    echo "act is not installed. Installing..."
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install act
        else
            echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
    else
        echo "Unsupported OS. Please install act manually: https://github.com/nektos/act#installation"
        exit 1
    fi
fi

# Create .actrc if it doesn't exist
if [ ! -f .actrc ]; then
    echo "Creating .actrc file..."
    cat > .actrc << EOF
-P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest
--container-architecture linux/amd64
EOF
fi

echo "act is now installed and configured."
echo "To run the pre-commit workflow locally, use:"
echo "act -W .github/workflows/pre-commit.yml"
echo ""
echo "For more information, see docs/local-workflow-validation.md"

# Ask if user wants to run the workflow now
read -p "Do you want to run the pre-commit workflow now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    act -W .github/workflows/pre-commit.yml
fi