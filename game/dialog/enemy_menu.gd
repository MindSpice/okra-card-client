extends Panel

var e_label_red = load("res://game/dialog/effect_label_red.tscn")
var e_label_green = load("res://game/dialog/effect_label_green.tscn")
var pawn_idx : int
onready var _stat_box = {
	Game.StatType.HP 		: $Stats1/HP,
	Game.StatType.DP 		: $Stats1/DP,
	Game.StatType.SP 		: $Stats1/SP,
	Game.StatType.MP 		: $Stats1/MP,
	Game.StatType.WILLPOWER : $Stats2/WP,
	Game.StatType.LUCK 		: $Stats2/LUCK
}

func set_stats(stats : Dictionary):
	if stats.size() <= 1 : clear_stats()
	for stat in stats:
		var s_value = stats.get(stat)
		if s_value != null:
			_stat_box.get(stat).text = str(_prefix(stat), s_value)

			
func _prefix(stat : int) -> String:
	match(stat):
		Game.StatType.HP: return "HP: "
		Game.StatType.DP: return "DP: "
		Game.StatType.SP: return "SP: "
		Game.StatType.MP: return "MP: "
		Game.StatType.WILLPOWER: return "WP: "
		Game.StatType.LUCK: return "LUCK: "
	return "err"


func clear_stats():
	for stat in _stat_box:
		match(stat):
			Game.StatType.DP: _stat_box.get(stat).text = "DP: ?"
			Game.StatType.SP: _stat_box.get(stat).text = "SP: ?"
			Game.StatType.MP: _stat_box.get(stat).text = "MP: ?"
			Game.StatType.WILLPOWER: _stat_box.get(stat).text = "WP: ?"
			Game.StatType.LUCK: _stat_box.get(stat).text = "LUCK: ?"
			

func set_effects(effects : Array):
	var effects_dict = Network.conv_effect_arr(effects)
	#Util.free_children($ScrollContainer/StatusEffects.add_child)

	for effect in effects_dict:
		var label : Node = (e_label_green.instance() 
							if effects_dict.get(effect)
							else e_label_red.instance())
		label.text = effect
		$ScrollContainer/StatusEffects.add_child(label)
