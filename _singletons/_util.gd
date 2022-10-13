extends Node

# Removes children from root, keep instances
func remove_children(root_node : Node) -> void:
	if root_node == null or root_node.get_children() == null:
		push_warning("Attempted To Remove On Null Node Or Children")
		return
		
	for child in root_node.get_children():
		root_node.remove_child(child)


# Removes childen from root, freeing instances (destroy)
func free_children(root_node : Node) -> void:
	if root_node == null or root_node.get_children() == null:
		push_warning("Attempted To Free On Null Node Or Children")
		return
	
	for child in root_node.get_children():
		child.queue_free()


func merge_children_to_array (array : Array, root_node : Node) -> void:
		if root_node == null or root_node.get_children() == null:
			push_warning("Attempted To Merge On Null Node Or Children")
			return
		
		for child in root_node.get_children():
			array.append(child)


func merge_non_duplicates(base : Array, merge : Array):
	for item in merge:
		if not base.has(item):
			base.append(item)


func erase_all(target_array : Array, array : Array) -> void:
	for item in array:
		target_array.erase(item)
