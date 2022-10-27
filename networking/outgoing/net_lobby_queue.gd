extends Reference

class_name NetLobbyQueue

var data : Dictionary


func _init(is_queue : bool, pawn_set : String) -> void:
	data["is_queue"] = is_queue;
	
	if pawn_set != "":
		data["pawn_set"] = pawn_set
		

