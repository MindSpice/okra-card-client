extends Reference

class_name NetGameOver

var is_player : bool

func _init(msg : Dictionary) :
	is_player = msg.get("is_player")

