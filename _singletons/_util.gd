extends Node

# Removes children from root, keep instances
func remove_children(root_node : Node):
	if root_node == null or root_node.get_children() == null:
		push_warning("Attempted To Remove On Null Node Or Children")
		return
		
	for child in root_node.get_children():
		root_node.remove_child(child)

# Removes childen from root, freeing instances (destroy)
func free_children(root_node : Node):
	if root_node == null or root_node.get_children() == null:
		push_warning("Attempted To Free On Null Node Or Children")
		return
	
	for child in root_node.get_children():
		child.queue_free()
		
