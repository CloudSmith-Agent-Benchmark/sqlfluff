"""The Test file for CLI helpers."""

import pytest

from sqlfluff.cli.helpers import LazySequence, pad_line, wrap_elem, wrap_field


@pytest.mark.parametrize(
    "in_str,length,res",
    [
        ("abc", 5, ["abc"]),
        # Space wrap test
        ("how now brown cow", 10, ["how now", "brown cow"]),
        # Harder wrap test
        ("A hippopotamus came for tea", 10, ["A hippopot", "amus came", "for tea"]),
        # Harder wrap test, with a newline.
        ("A hippopotamus\ncame for tea", 10, ["A hippopot", "amus came", "for tea"]),
    ],
)


def test__cli__helpers__pad_line():
    """Test line padding."""
    assert pad_line("abc", 5) == "abc  "
    assert pad_line("abcdef", 10, align="right") == "    abcdef"


def test_cli__helpers__lazy_sequence():
    """Test the LazySequence."""
    getter_run = False

    def _get_sequence():
        nonlocal getter_run
        getter_run = True
        return [1, 2, 3]

    seq = LazySequence(_get_sequence)
    # Check the sequence isn't called on instantiation.
    assert not getter_run
    # Fetch an item...
    assert seq[2] == 3
    # .. and that now it has run.
    assert getter_run

    # Check other methods work
    assert len(seq) == 3
