from otkt.otelinit import tracer

from anytree import Node, RenderTree
from anytree.exporter import DotExporter
from anytree.iterators import PreOrderIter, LevelOrderIter

# Creating a tree structure
root = Node("Root")
child1 = Node("Child1", parent=root)
child2 = Node("Child2", parent=root)
child1_1 = Node("Child1_1", parent=child1)
child1_2 = Node("Child1_2", parent=child1)
child2_1 = Node("Child2_1", parent=child2)

# Displaying the tree structure
print("Tree Structure:")
for pre, _, node in RenderTree(root):
    print(f"{pre}{node.name}")

# Iterating through the tree using PreOrder and LevelOrder traversal
print("\nPreOrder Traversal:")
for node in PreOrderIter(root):
    print(node.name)

print("\nLevelOrder Traversal:")
for node in LevelOrderIter(root):
    print(node.name)

# Exporting the tree visualization as an image (requires Graphviz installed)
DotExporter(root).to_picture("tree.png")
print("\nTree structure saved as tree.png")