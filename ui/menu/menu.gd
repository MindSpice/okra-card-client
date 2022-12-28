extends Control

var _confirm_join := preload("res://ui/menu/confirm_queue.tscn").instance()
var _queue_menu := preload("res://ui/menu/queue.tscn").instance()
var _token_menu := preload("res://ui/menu/token_menu.tscn").instance()
var _dialog := preload("res://ui/simple_dialog.tscn").instance()

onready var _queued_box := $MenuPane/QueueBox

func _ready() -> void:
	add_child(_confirm_join)
	add_child(_queue_menu)
	add_child(_token_menu)

func _on_Builder_pressed():
	# add_child(_confirm_join)
	# $CenterContainer.queue_free()
	get_tree().change_scene("res://ui/set_builder/set_builder.tscn")


func _on_Queue_pressed() -> void:
	_queue_menu.popup_centered()


func _on_queue_confirm() -> void:
	pass

func _on_Leave_pressed() -> void:
	Network.send(NetLobbyQueue.new(false, -1, []))
	_queued_box.hide()



func _on_msg(valid: bool, msg: String, context: String) -> void:
	if context == "join":
		_queued_box.show()
	if context == "leave":
		_queued_box.hide()
	_dialog.set_text(msg)
	_dialog.popup_centered()



func _on_Tokens_pressed():
	_token_menu.popup_centered()
