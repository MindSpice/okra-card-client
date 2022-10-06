extends MarginContainer
class_name Card


var info : Array
var card_name : String
var card_type : String
var card_class : String
var card_level : int



func init(name : String, info : Array):
	self.info = info
	card_name = name # TODO this needs to be pass along with the info
	card_type = info[1]
	card_class = info[0]
	card_level = info[2]
	$Image.texture = load(str(CardBase.ACTION_RES,name,".jpg"))
	$Image.scale  = Vector2(.3, .3)

func _ready():
	pass
	
