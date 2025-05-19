from otkt.instrument import instrument
class TreeError(RuntimeError):
    """Tree Error."""


class LoopError(TreeError):
    """Tree contains infinite loop."""
