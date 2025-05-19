from otkt.instrument import instrument
from anytree import Node
from anytree.util import commonancestors, leftsibling, rightsibling

from .helper import eq_


@instrument
def test_commonancestors():
    """Commonancestors."""
    udo = Node("Udo")
    marc = Node("Marc", parent=udo)
    lian = Node("Lian", parent=marc)
    dan = Node("Dan", parent=udo)
    jet = Node("Jet", parent=dan)
    joe = Node("Joe", parent=dan)

    eq_(commonancestors(jet, joe), (udo, dan))
    eq_(commonancestors(jet, marc), (udo,))
    eq_(commonancestors(jet), (udo, dan))
    eq_(commonancestors(), ())
    eq_(commonancestors(jet, lian), (udo,))


@instrument
def test_leftsibling():
    """Leftsibling."""
    dan = Node("Dan")
    jet = Node("Jet", parent=dan)
    jan = Node("Jan", parent=dan)
    joe = Node("Joe", parent=dan)
    eq_(leftsibling(dan), None)
    eq_(leftsibling(jet), None)
    eq_(leftsibling(jan), jet)
    eq_(leftsibling(joe), jan)


@instrument
def test_rightsibling():
    """Rightsibling."""
    dan = Node("Dan")
    jet = Node("Jet", parent=dan)
    jan = Node("Jan", parent=dan)
    joe = Node("Joe", parent=dan)
    eq_(rightsibling(dan), None)
    eq_(rightsibling(jet), jan)
    eq_(rightsibling(jan), joe)
    eq_(rightsibling(joe), None)
