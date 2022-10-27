extends Reference

class_name StatMap

var _stats : Dictionary

func _init(HP : int, DP: int, SP : int, MP : int, WILLPOWER : int, LUCK : int):
	_stats[Game.StatType.HP] = HP
	_stats[Game.StatType.DP] = DP
	_stats[Game.StatType.SP] = SP
	_stats[Game.StatType.MP] = MP
	_stats[Game.StatType.WILLPOWER] = WILLPOWER
	_stats[Game.StatType.LUCK] = LUCK
	
	
func get_stat(stat : int) -> int:
	return _stats.get(stat)
	
	
func set_all(stats : Dictionary):
	_stats = stats
