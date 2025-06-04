"""Defines the base dialect class."""

import sys
from typing import Any, Optional, Union, cast

from sqlfluff.core.parser import (
    BaseSegment,
    KeywordSegment,
    SegmentGenerator,
    StringParser,
)
from sqlfluff.core.parser.grammar.base import BaseGrammar, Nothing
from sqlfluff.core.parser.lexer import LexerType
from sqlfluff.core.parser.matchable import Matchable
from sqlfluff.core.parser.types import BracketPairTuple, DialectElementType


class Dialect:
    """Serves as the basis for runtime resolution of Grammar.

    Args:
        name (:obj:`str`): The name of the dialect, used for lookup.
        lexer_matchers (iterable of :obj:`StringLexer`): A structure defining
            the lexing config for this dialect.

    """

    def __init__(
        self,
        name: str,
        root_segment_name: str,
        lexer_matchers: Optional[list[LexerType]] = None,
        library: Optional[dict[str, DialectElementType]] = None,
        sets: Optional[dict[str, set[Union[str, BracketPairTuple]]]] = None,
        inherits_from: Optional[str] = None,
        formatted_name: Optional[str] = None,
        docstring: Optional[str] = None,
    ) -> None:
        self._library = library or {}
        self.name = name
        self.lexer_matchers = lexer_matchers
        self.expanded = False
        self._sets = sets or {}
        self.inherits_from = inherits_from
        self.root_segment_name = root_segment_name
        # Attributes for documentation
        self.formatted_name: str = formatted_name or name
        self.docstring = docstring or f"The dialect for {self.formatted_name}."