extends MarginContainer
class_name Card

onready var info

func init(card:String):
	info = CardBase.ACTIONCARD[card]
	$Image.texture = load(str(CardBase.ACTION_RES,card,".jpg"))
	$Image.scale  = Vector2(.3, .3)


func _ready():
	pass
