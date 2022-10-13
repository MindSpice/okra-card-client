extends Reference

class_name PawnSet
var set_name : String
var pawn_loadouts : Dictionary
var power_deck : Array
var preferred_potions : Array


func get_pawn_loadout(pawn_idx : int) -> PawnLoadout:
	return pawn_loadouts.get(pawn_idx)
	
	
func set_pawn_loadout(pawn_idx: int, pawn_loadout : PawnLoadout):
	pawn_loadouts[pawn_idx] = pawn_loadout
	

func is_valid() -> bool:
	if pawn_loadouts.size() < 3:
		return false
		
	for pawn in pawn_loadouts:
		if pawn.is_valid == false:
			return false
	
	if power_deck.size() > Game.POWER_MAX or power_deck.size() < Game.POWER_MIN:
		return false	
		
	return true
	
func get_as_dict() -> Dictionary:
	return {
		"set_name" : set_name,
		"power_deck" : power_deck,
		"preferred_potions" : preferred_potions,
		"PAWN1" : pawn_loadouts[0].get_as_dict(),
		"PAWN2" : pawn_loadouts[1].get_as_dict(),
		"PAWN3" : pawn_loadouts[2].get_as_dict(),
	}
