extends Reference

class_name PawnSet
var set_name : String
var power_deck : Array
var preferred_potions : Array
var pawn_loadouts : Array


func _init():
	for i in 3:
		pawn_loadouts.append(PawnLoadout.new())

func is_valid() -> bool:
	if pawn_loadouts.size() < 3:
		return false
		
	for pawn in pawn_loadouts:
		if not pawn.is_valid():
			return false
	
	if power_deck.size() > Game.POWER_MAX or power_deck.size() < Game.POWER_MIN:
		return false	
		
	return true
	
func get_as_dict() -> Dictionary:
	if not is_valid():
		push_error("Invalid PawnSet")
		#return {}
	
	var p_deck_names : Array
	for card in power_deck:
		p_deck_names.append(card.card_name)
		
	return {
		"set_name" : set_name,
		"power_deck" : p_deck_names,
		"preferred_potions" : preferred_potions,
		"PAWN1" : pawn_loadouts[0].get_as_dict(),
		"PAWN2" : pawn_loadouts[1].get_as_dict(),
		"PAWN3" : pawn_loadouts[2].get_as_dict(),
	}
	
func clean_up() -> void:
	for pl in pawn_loadouts:
		pl.clean_up()
	Util.free_array(power_deck)
	
