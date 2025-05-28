"""Tests for the string helper functions."""

import pytest

from sqlfluff.core.helpers.string import findall, curtail_string, split_comma_separated_string


def test_findall_with_valid_inputs():
    """Test the findall function with valid inputs."""
    result = list(findall("a", "ababa"))
    assert result == [0, 2, 4]

    result = list(findall("ab", "ababa"))
    assert result == [0, 2]

    result = list(findall("x", "ababa"))
    assert result == []


def test_findall_with_invalid_inputs():
    """Test the findall function with invalid inputs."""
    # Test with None values
    with pytest.raises(TypeError):
        list(findall(None, "ababa"))
    
    with pytest.raises(TypeError):
        list(findall("a", None))
    
    # Test with empty strings
    result = list(findall("", "ababa"))
    assert result == []
    
    result = list(findall("a", ""))
    assert result == []
