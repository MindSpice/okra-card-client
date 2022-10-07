extends Node
const ACTION_MIN : int = 6
const ACTION_MAX : int = 10
const ABILITY_MIN : int = 9
const ABILITY_MAX : int = 15
const POWER_MIN : int = 9
const POWER_MAX : int = 15
const ACTION_LEVEL_MEDIAN : float = 2.5
const ABILITY_LEVEL_MEDIAN : float = 2.5
const POWER_LEVEL_MEDIAN : float = 2.5

enum Domain {ACTION, ABILITY, POWER}
	
func get_deck_limit(domain : int, count : int) -> float:
	match (domain):
		Domain.ACTION:
			if count <= ACTION_MIN:
				return ACTION_MIN * ACTION_LEVEL_MEDIAN
			else:
				return count * ACTION_LEVEL_MEDIAN
		Domain.ABILITY:
			if count <= ABILITY_MIN:
				return ABILITY_MIN * ABILITY_LEVEL_MEDIAN
			else:
				return count * ABILITY_LEVEL_MEDIAN
		Domain.POWER:
			if count <= POWER_MIN:
				return POWER_MIN * POWER_LEVEL_MEDIAN
			else:
				return count * POWER_LEVEL_MEDIAN
	return 0.0
	

func get_deck_contraints(domain : int) -> Vector2:
	match (domain):
		Domain.ACTION:
			return Vector2(ACTION_MIN, ACTION_MAX)
		Domain.ABILITY:
			return Vector2(ABILITY_MIN, ABILITY_MAX)
		Domain.POWER:
			return Vector2(POWER_MIN, POWER_MAX)
	return Vector2(0,0)


		
