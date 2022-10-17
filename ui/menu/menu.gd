extends Control

func _on_Builder_pressed():
	$CenterContainer.queue_free()
	get_tree().change_scene("res://ui/set_builder/set_builder.tscn")


func _on_Queue_pressed() -> void:
	$CenterContainer.queue_free()
	get_tree().change_scene("res://gameview/gameview2.tscn")
