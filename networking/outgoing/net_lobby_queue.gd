extends Reference

class_name NetLobbyQueue

var data : Dictionary


func _init(is_queue: bool, pawn_set: int, potions: Array) -> void:
	
	data["msg_type"] = Network.conv_msg_out(
		Network.MsgOut.JOIN_QUEUE 
		if is_queue 
		else Network.MsgOut.LEAVE_QUEUE
	)
	
	if pawn_set != null:
		data["pawn_set"] = pawn_set
	
	if potions != null or not potions.empty():
		data[potions] = potions


		

