extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func set_hidden(hidden):
	for child in get_children():
		pass

func set_disabled_all(disabled):
	for child in get_children():
		child.disabled = disabled

func set_disabled_single(action :int, disabled):
	if action == Game.PlayerAction.ATTACK_LIGHT:
		$LightAttack.disabled = disabled
	else:
		$HeavyAttack.disabled = disabled


			
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
