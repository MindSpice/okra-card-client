extends Control



func _on_Builder_pressed():
	$CenterContainer.queue_free()
	get_tree().change_scene("res://ui/set_builder/set_builder.tscn")
