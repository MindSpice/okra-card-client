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
		
func free_array(array : Array):
		for item in array:
			item.queue_free()
		array.clear()


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




#func free_matches_from (target_array : Array, array : Array) -> void:
#	for item in array:
#		var idx = target_array.find(item)
#		var target = target_array[idx]
#		if target != null:
#			target_array.remove(idx)
#			target.queue_free()
