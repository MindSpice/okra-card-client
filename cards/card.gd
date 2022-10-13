extends MarginContainer

class_name Card

var card_info : Array
var card_name : String
var card_type : String
var card_class : String
var card_level : int
var card_domain : int
var mouse_on : bool 
var is_in_deck : bool = false
var disable_context : bool = false

func init(domain : int, name : String, info : Array):
	card_domain = domain
	card_info = info
	card_name = name # TODO this needs to be pass along with the info
	card_type = info[1]
	card_class = info[0]
	card_level = info[2]
	$Image.texture = load(str(CardBase.ACTION_RES,name,".jpg"))
	$Image.scale  = Vector2(.3, .3)


func _ready():
	pass
	
	
func get_image() -> Texture:
	return $Image.texture
	
	
func set_scalar(scalar : float):
	$Image.scale = Vector2(scalar, scalar)
	
	
func _input(event):
	$Menu.set_item_disabled(0, true if is_in_deck else false)
	$Menu.set_item_disabled(1, false if is_in_deck else true)

	if (event is InputEventMouseButton and event.is_pressed() 
			and (event.button_index == BUTTON_LEFT or event.button_index == BUTTON_RIGHT)):
				
		if not disable_context:
			if not $Menu.is_visible_in_tree() && mouse_on:
				$Menu.popup(Rect2(get_global_mouse_position().x, get_global_mouse_position().y, 75, 75))
		else:
			if (mouse_on):
				emit_signal("card_selected", self)
				


func enable_select(flag : bool):
	disable_context = flag
	

func _on_Card_mouse_entered():
	mouse_on = true


func _on_Card_mouse_exited():
	mouse_on = false
	
func get_context() -> Node:
	return $Menu
	
	
signal card_selected(card)
	
	
signal context_selected(card , id)


func _on_context_id_pressed(id):
	emit_signal("context_selected", self, id)
