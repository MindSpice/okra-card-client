extends Reference

class_name PawnSet

var pawn_loadouts : Dictionary
var power_cards : Array
var perferred_potions : Array


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
	
	if power_cards.size() > Game.POWER_MAX or power_cards.size() < Game.POWER_MIN:
		return false	
		
	return true
