"""Tests for the string validator functions."""

import pytest

from sqlfluff.core.helpers.string_validator import validate_string_input, extract_sql_identifier


class TestValidateStringInput:
    """Tests for the validate_string_input function."""

    def test_valid_string(self):
        """Test with a valid string."""
        result = validate_string_input("test", "test_function")
        assert result == "test"

    def test_none_input(self):
        """Test with None input."""
        with pytest.raises(TypeError, match="test_function received None instead of a string"):
            validate_string_input(None, "test_function")

    def test_non_string_input(self):
        """Test with non-string input."""
        with pytest.raises(TypeError, match="test_function expected string but received int"):
            validate_string_input(123, "test_function")

    def test_empty_string(self):
        """Test with empty string."""
        with pytest.raises(ValueError, match="test_function received an empty string"):
            validate_string_input("", "test_function")


class TestExtractSqlIdentifier:
    """Tests for the extract_sql_identifier function."""

    def test_normal_identifier(self):
        """Test with a normal identifier."""
        result = extract_sql_identifier("column_name")
        assert result == "column_name"

    def test_quoted_identifier(self):
        """Test with a quoted identifier."""
        result = extract_sql_identifier('"column_name"')
        assert result == "column_name"

    def test_empty_string(self):
        """Test with an empty string."""
        result = extract_sql_identifier("")
        assert result == ""
        # This test passes but it should probably fail since empty identifiers are invalid

    def test_none_input(self):
        """Test with None input - this should fail but doesn't."""
        result = extract_sql_identifier(None)
        assert result == ""
        # This test passes but it should fail with a TypeError

    def test_none_input_should_fail(self):
        """Test that demonstrates the bug - None input should raise an exception."""
        # This test will fail because extract_sql_identifier doesn't validate its input
        with pytest.raises(TypeError):
            extract_sql_identifier(None)
