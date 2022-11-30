extends TextureRect

var _mouse_on : bool
var card_slot : int
var disabled : bool

func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	set_hidden(true)

	
func _input(event):
	if _mouse_on == false or disabled:
		return

	if (event is InputEventMouseButton and event.is_pressed() 
		and (event.button_index == BUTTON_LEFT or event.button_index == BUTTON_RIGHT)):
			emit_signal("selected", card_slot)
			get_tree().set_input_as_handled()
			_mouse_on = false
			
			

func set_hidden(hidden):
	set_process_input(false if hidden else true)


		
		
func _on_mouse_entered():
	_mouse_on = true
		
		
func _on_mouse_exited():
	_mouse_on = false


signal selected(card_slot)
