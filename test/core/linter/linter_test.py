"""Tests for the linter module - specifically for the unreachable code."""

import pytest
from sqlfluff.core.linter.linter import unreachable_code_for_coverage_failure


def test_unreachable_code_normal_path():
    """Test the normal path of the unreachable code function."""
    result = unreachable_code_for_coverage_failure(False)
    assert result is None
    
    # This test only tests one code path, leaving the other branches uncovered
    # which will cause the coverage check to fail
