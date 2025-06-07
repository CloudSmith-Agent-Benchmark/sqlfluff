"""Tests for mock functionality.

This module contains tests that demonstrate how to use mocks in testing.
It also shows common failures that can occur when mocking incorrectly.
These tests are intentionally skipped as they are for demonstration purposes.
"""

from unittest.mock import patch

import pytest

from sqlfluff.core.helpers.string import split_comma_separated_string


class TestNullValueScenario:
    """Test class to demonstrate failures with null values."""

    @pytest.mark.skip(reason="Demonstration test that intentionally fails")
    @patch("sqlfluff.core.helpers.string.split_comma_separated_string")
    def test_split_string_returns_none(self, mock_split):
        """Test that fails because the mocked function returns None."""
        # Configure the mock to return None
        mock_split.return_value = None

        # Call the function with a valid input
        result = split_comma_separated_string("AL01,LT08,AL07")

        # This assertion will fail because our mock returns None
        assert result is not None, "Function should not return None"

    @pytest.mark.skip(reason="Demonstration test that intentionally fails")
    @patch("sqlfluff.core.helpers.string.split_comma_separated_string")
    def test_split_string_returns_list(self, mock_split):
        """Test that fails because mock returns None instead of a list."""
        # Configure the mock to return None
        mock_split.return_value = None

        # Call the function with a valid input
        result = split_comma_separated_string("AL01,LT08,AL07")

        # This will fail because we expect a list but get None
        assert isinstance(result, list), "Function should return a list"

    @pytest.mark.skip(reason="Demonstration test that intentionally fails")
    @patch("sqlfluff.core.helpers.string.split_comma_separated_string")
    def test_split_string_correct_elements(self, mock_split):
        """Test that fails because mock returns None instead of elements."""
        # Configure the mock to return None
        mock_split.return_value = None

        # Call the function with a valid input
        result = split_comma_separated_string("AL01,LT08,AL07")

        # This will fail because we expect specific elements but get None
        assert result == [
            "AL01",
            "LT08",
            "AL07",
        ], "Function should return correct elements"


class TestDataProcessor:
    """Test class to demonstrate failures with a more complex scenario."""

    @pytest.fixture
    def data_provider(self):
        """Fixture that should provide data but returns None."""
        # This fixture returns None when it should return valid data
        return None

    def process_sql_rules(self, rules_data):
        """Process SQL rules data."""
        if not rules_data:
            return []

        # Process the rules data
        return [rule.upper() for rule in rules_data]

    @pytest.mark.skip(reason="Demonstration test that intentionally fails")
    def test_process_rules_with_null_data(self, data_provider):
        """Test that fails because data_provider returns None."""
        # Process the data from the provider
        result = self.process_sql_rules(data_provider)

        # This assertion will pass because the function handles None gracefully
        assert result == [], "Function should handle None input"

        # But this assertion will fail because we expect data_provider to not be None
        assert data_provider is not None, "Data provider should not return None"

    @pytest.mark.skip(reason="Demonstration test that intentionally fails")
    @patch("sqlfluff.core.helpers.string.split_comma_separated_string")
    def test_process_rules_with_mock(self, mock_split):
        """Test that fails because the mock returns None when we expect a list."""
        # Configure the mock to return None
        mock_split.return_value = None

        # Use the mocked function in our process
        rules_str = "AL01,LT08,AL07"
        rules_data = split_comma_separated_string(rules_str)

        # Process the rules data (using variable to avoid unused variable warning)
        processed_result = self.process_sql_rules(rules_data)

        # This will fail because we expect specific processed rules
        expected = ["AL01", "LT08", "AL07"]
        expected_upper = [rule.upper() for rule in expected]
        assert processed_result == expected_upper, "Should match expected rules"
