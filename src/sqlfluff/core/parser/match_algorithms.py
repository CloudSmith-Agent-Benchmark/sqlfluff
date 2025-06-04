"""Matching algorithms.

These are mostly extracted from the body of either BaseSegment
or BaseGrammar to un-bloat those classes.
"""

from collections import defaultdict
from collections.abc import Sequence
from typing import DefaultDict, Optional, cast

from sqlfluff.core.errors import SQLParseError
from sqlfluff.core.parser.context import ParseContext
from sqlfluff.core.parser.match_result import MatchResult
from sqlfluff.core.parser.matchable import Matchable
from sqlfluff.core.parser.segments import BaseSegment, BracketedSegment, Dedent, Indent


def skip_start_index_forward_to_code(
    segments: Sequence[BaseSegment], start_idx: int, max_idx: Optional[int] = None
) -> int:
    """Move an index forward through segments until segments[index] is code."""
    if max_idx is None:
        max_idx = len(segments)
    for _idx in range(start_idx, max_idx):
        if segments[_idx].is_code:
            break
    else:
        _idx = max_idx
    return _idx


def skip_stop_index_backward_to_code(
    segments: Sequence[BaseSegment], stop_idx: int, min_idx: int = 0
) -> int:
    """Move an index backward through segments until segments[index - 1] is code."""
    for _idx in range(stop_idx, min_idx, -1):
        if segments[_idx - 1].is_code:
            break
    else:
        _idx = min_idx
    return _idx