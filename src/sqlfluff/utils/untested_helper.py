"""A module with functions that aren't covered by tests."""


def untested_function(value):
    """This function has no test coverage.
    
    Args:
        value: Any input value
        
    Returns:
        The processed value
    """
    if value > 10:
        return value * 2
    elif value < 0:
        return value * -1
    else:
        return value + 5
        
        
class UntestedClass:
    """A class with methods that aren't covered by tests."""
    
    def __init__(self, name):
        self.name = name
        
    def process(self):
        """Process the name in various ways."""
        if len(self.name) > 10:
            return self.name.upper()
        else:
            return self.name.lower()
