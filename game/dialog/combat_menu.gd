extends Panel

var _e_label_red = load("res://game/dialog/effect_label_red.tscn")
var _e_label_green = load("res://game/dialog/effect_label_green.tscn")


onready var _stat_box = {
	Game.StatType.HP 		: $Stats1/HP,
	Game.StatType.DP 		: $Stats1/DP,
	Game.StatType.SP 		: $Stats1/SP,
	Game.StatType.MP 		: $Stats1/MP,
	Game.StatType.WILLPOWER : $Stats2/WP,
	Game.StatType.LUCK 		: $Stats2/LUCK
}


func _ready():
	$InputBox/LightAttack.connect("pressed", self, "_on_light_attack")
	$InputBox/HeavyAttack.connect("pressed", self, "_on_heavy_attack")
	$InputBox/PlayCard.connect("pressed", self, "_on_play_card")
	$InputBox/Potion.connect("pressed", self, "_on_potion")
	$InputBox/SkipTurn.connect("pressed", self, "_on_skip_turn")
	$CardSelect/Exit.connect("pressed", self, "_on_select_exit")

	$CardSelect/HBox/Action1.card_slot = Game.PlayerAction.ACTION_CARD_1
	$CardSelect/HBox/Action1.connect("selected", self, "_on_card_select")

	$CardSelect/HBox/Action2.card_slot = Game.PlayerAction.ACTION_CARD_2
	$CardSelect/HBox/Action2.connect("selected", self, "_on_card_select")

	$CardSelect/HBox/Ability.card_slot = Game.PlayerAction.ABILITY_CARD
	$CardSelect/HBox/Ability.connect("selected", self, "_on_card_select")



	


func set_stats(stats : Dictionary):
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


func set_effects(effects : Array):
	var effects_dict = Network.conv_effect_arr(effects)
	Util.free_children($ScrollContainer/StatusEffects)

	for effect in effects_dict:
		var label : Node = (_e_label_green.instance() 
							if effects_dict.get(effect)
							else _e_label_red.instance())
		label.text = effect
		$ScrollContainer/StatusEffects.add_child(label)


func disable_card(card_slot : int):
	match(card_slot):
		Game.PlayerAction.ACTION_CARD_1:
			$CardSelect/HBox/Action1.texture = null
			$CardSelect/HBox/Action1.enabled = false
		Game.PlayerAction.ACTION_CARD_2:
			$CardSelect/HBox/Action2.texture = null
			$CardSelect/HBox/Action2.enabled = false
		Game.PlayerAction.ABILITY_CARD:
			$CardSelect/HBox/Ability.texture = null
			$CardSelect/HBox/Ability.enabled = false

# TODO add code to disable input for buttons if stats are not enough

func set_card(card_slot : int, card: Card):
	match(card_slot):
		Game.PlayerAction.ACTION_CARD_1:
			$CardSelect/HBox/Action1.texture = card.get_image()
			$CardSelect/HBox/Action1.enabled = true
		Game.PlayerAction.ACTION_CARD_2:
			$CardSelect/HBox/Action2.texture = card.get_image()
			$CardSelect/HBox/Action2.enabled = true
		Game.PlayerAction.ABILITY_CARD:
			$CardSelect/HBox/Ability.texture = card.get_image()
			$CardSelect/HBox/Ability.enabled = true



# Signal Binds

func _on_light_attack():
	emit_signal("action_input", Game.PlayerAction.ATTACK_LIGHT)


func _on_heavy_attack():
	emit_signal("action_input", Game.PlayerAction.ATTACK_HEAVY)


func _on_play_card():
	$CardSelect.set_hidden(false)

func _on_potion():
	emit_signal("action_input", Game.PlayerAction.POTION)
	

func _on_skip_turn():
	emit_signal("action_input", Game.PlayerAction.SKIP_PAWN)


func _on_select_exit():
	$CardSelect.set_hidden(true)



func _on_card_select(card_slot : int):
	emit_signal("action_input", card_slot)
	$CardSelect.set_hidden(true)


signal action_input(action)
			


#110x79
