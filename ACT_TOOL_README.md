# Act Tool for Local GitHub Actions Testing

This repository includes a script to install the [act](https://github.com/nektos/act) tool, which allows you to run GitHub Actions workflows locally.

## What is Act?

Act is a command-line tool that allows you to run GitHub Actions locally. It uses Docker to run the actions in a similar environment to GitHub's runners.

## Installation

You can install the act tool by running the provided script:

```bash
# Make the script executable
chmod +x install-act.sh

# Run the installation script
./install-act.sh
```

The script will automatically detect your operating system and install act accordingly:
- On Linux: Downloads the latest release from GitHub
- On macOS: Uses Homebrew to install act

## Usage

Once installed, you can run GitHub Actions workflows locally:

```bash
# Run the default workflow
act

# Run a specific workflow
act -W .github/workflows/pre-commit.yml

# Run a specific job
act -j pre-commit
```

## Requirements

- Docker must be installed and running
- On Linux: curl and sudo access
- On macOS: Homebrew (recommended)

## More Information

For more information about the act tool, visit the [official GitHub repository](https://github.com/nektos/act).