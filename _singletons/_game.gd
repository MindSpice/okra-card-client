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

func get_action_limit(count : int) -> float:
	return count * ACTION_LEVEL_MEDIAN
	
func get_ability_limit(count : int) -> float:
	return count * ABILITY_LEVEL_MEDIAN
	
func get_Power_limit(count : int) -> float:
	return count * POWER_LEVEL_MEDIAN
