extends MarginContainer
class_name Card


var info : Array
var card_name : String


func init(card : String):
	card_name = card
	info = CardBase.ACTIONCARD[card]
	$Image.texture = load(str(CardBase.ACTION_RES,card,".jpg"))
	$Image.scale  = Vector2(.3, .3)


func _ready():
	pass
