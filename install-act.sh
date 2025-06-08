#!/bin/bash

# Script to install the act tool for local GitHub Actions testing
# This script will install the act tool if it's not already installed

set -e

echo "Checking if act is already installed..."
if command -v act &> /dev/null; then
    echo "act is already installed."
    act --version
    exit 0
fi

echo "Installing act tool..."

# Determine OS type
OS="$(uname -s)"
case "${OS}" in
    Linux*)     
        echo "Detected Linux system"
        # For Linux, we'll download the latest release from GitHub
        LATEST_VERSION=$(curl -s https://api.github.com/repos/nektos/act/releases/latest | grep -Po '"tag_name": "v\K[0-9.]+')
        echo "Latest version: ${LATEST_VERSION}"
        
        # Create a temporary directory for download
        TMP_DIR=$(mktemp -d)
        cd ${TMP_DIR}
        
        # Download the binary
        echo "Downloading act..."
        curl -sL "https://github.com/nektos/act/releases/download/v${LATEST_VERSION}/act_Linux_x86_64.tar.gz" -o act.tar.gz
        
        # Extract and install
        echo "Extracting..."
        tar xzf act.tar.gz
        echo "Installing to /usr/local/bin/act (may require sudo)..."
        sudo mv act /usr/local/bin/
        
        # Clean up
        cd - > /dev/null
        rm -rf ${TMP_DIR}
        ;;
    Darwin*)    
        echo "Detected macOS system"
        # For macOS, recommend using Homebrew
        if command -v brew &> /dev/null; then
            echo "Installing act using Homebrew..."
            brew install act
        else
            echo "Homebrew not found. Please install Homebrew first with:"
            echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
            echo "Then run: brew install act"
            exit 1
        fi
        ;;
    *)          
        echo "Unsupported operating system: ${OS}"
        echo "Please install act manually following instructions at: https://github.com/nektos/act"
        exit 1
        ;;
esac

# Verify installation
if command -v act &> /dev/null; then
    echo "act installed successfully!"
    act --version
    echo ""
    echo "You can now run GitHub Actions locally using: act"
    echo "For more information, visit: https://github.com/nektos/act"
else
    echo "Installation failed. Please install act manually."
    echo "Visit: https://github.com/nektos/act"
    exit 1
fi