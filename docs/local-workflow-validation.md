# Local Workflow Validation

This document provides instructions on how to validate GitHub Actions workflows locally before pushing changes to the repository.

## Installing and Using Act

[Act](https://github.com/nektos/act) is a tool that allows you to run GitHub Actions workflows locally. This is useful for testing workflow changes before pushing them to the repository.

### Installation

#### macOS
```bash
brew install act
```

#### Linux
```bash
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

#### Windows
```bash
choco install act-cli
```

Or download the latest release from the [GitHub releases page](https://github.com/nektos/act/releases).

### Usage

To run all workflows:
```bash
act
```

To run a specific workflow:
```bash
act -W .github/workflows/pre-commit.yml
```

To run a specific job:
```bash
act -j pre-commit
```

To run a workflow with a specific event:
```bash
act push
```

### Configuration

Create a `.actrc` file in the root of your repository to configure act:

```
-P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest
--container-architecture linux/amd64
```

### Additional Resources

- [Act GitHub Repository](https://github.com/nektos/act)
- [Act Documentation](https://github.com/nektos/act#readme)