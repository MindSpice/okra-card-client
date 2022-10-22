extends Reference

class_name NetLobbyMsg

var msg_type : String
var pawn_set : Dictionary
var msg_value : String


func _init(msg_type : String, pawn_set : Dictionary, msg_value : String) -> void:
	self.msg_type = msg_type;
	self.pawn_set = pawn_set;
	self. msg_value = msg_value;
