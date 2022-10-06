extends Node

# Removes children from root, keep instances
func remove_children(root_node : Node):
	for child in root_node.get_children():
		root_node.remove_child(child)

# Removes childen from root, freeing instances (destroy)
func free_children(root_node : Node):
	for child in root_node.get_children():
		child.queue_free()
