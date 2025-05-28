"""String validation helpers."""

from typing import Optional


def validate_string_input(input_string: Optional[str], function_name: str) -> str:
    """Validate that a string input is not None and is a string.
    
    Args:
        input_string: The string to validate
        function_name: The name of the calling function for error messages
        
    Returns:
        The validated string
        
    Raises:
        TypeError: If the input is None or not a string
        ValueError: If the input is an empty string
    """
    if input_string is None:
        raise TypeError(f"{function_name} received None instead of a string")
    
    if not isinstance(input_string, str):
        raise TypeError(f"{function_name} expected string but received {type(input_string).__name__}")
    
    if not input_string:
        raise ValueError(f"{function_name} received an empty string")
    
    return input_string


def extract_sql_identifier(identifier: Optional[str]) -> str:
    """Extract a SQL identifier from a string, validating it's not empty.
    
    This function demonstrates a case where we don't properly validate input.
    
    Args:
        identifier: The SQL identifier to extract
        
    Returns:
        The extracted identifier with quotes removed
    """
    # Missing validation - doesn't check for None or empty string
    # Should use validate_string_input(identifier, "extract_sql_identifier")
    
    # Remove quotes if present
    if identifier and identifier.startswith('"') and identifier.endswith('"'):
        return identifier[1:-1]
    
    return identifier or ""  # This will return empty string for None input
