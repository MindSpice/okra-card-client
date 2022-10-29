extends Panel

var _e_label_red = load("res://game/dialog/effect_label_red.tscn")
var _e_label_green = load("res://game/dialog/effect_label_green.tscn")
onready var _action_card_1 := $CardSelect/HBox/Action1
onready var _action_card_2 := $CardSelect/HBox/Action2
onready var _ability_card := $CardSelect/HBox/Ability
onready var _input_box := $InputBox
onready var _card_select := $CardSelect/


onready var _stat_box = {
	Game.StatType.HP 		: $Stats1/HP,
	Game.StatType.DP 		: $Stats1/DP,
	Game.StatType.SP 		: $Stats1/SP,
	Game.StatType.MP 		: $Stats1/MP,
	Game.StatType.WILLPOWER : $Stats2/WP,
	Game.StatType.LUCK 		: $Stats2/LUCK
}

var tcard := CardBase.instance_card(Game.Domain.ACTION, "ONE")
func _ready():
	$InputBox/LightAttack.connect("pressed", self, "_on_light_attack")
	$InputBox/HeavyAttack.connect("pressed", self, "_on_heavy_attack")
	$InputBox/PlayCard.connect("pressed", self, "_on_play_card")
	$InputBox/Potion.connect("pressed", self, "_on_potion")
	$InputBox/SkipTurn.connect("pressed", self, "_on_skip_turn")
	$CardSelect/Exit.connect("pressed", self, "_on_select_exit")

	_action_card_1.card_slot = Game.PlayerAction.ACTION_CARD_1
	_action_card_1.connect("selected", self, "_on_card_select")
	
	

	_action_card_2.card_slot = Game.PlayerAction.ACTION_CARD_2
	_action_card_2.connect("selected", self, "_on_card_select")

	_ability_card.card_slot = Game.PlayerAction.ABILITY_CARD
	_ability_card.connect("selected", self, "_on_card_select")


	

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


func disable_action(action : int):
	match(action):
		Game.PlayerAction.ACTION_CARD_1:
			_action_card_1.texture = null
			_action_card_1.disabled = true	
		Game.PlayerAction.ACTION_CARD_2:
			_action_card_2.texture = null
			_action_card_2.disabled = true
		Game.PlayerAction.ABILITY_CARD:
			_ability_card.texture = null
			_ability_card.disabled = true
		Game.PlayerAction.ATTACK_LIGHT:
			_input_box.set_disabled_single(action)
		Game.PlayerAction.ATTACK_HEAVY:
			_input_box.set_disabled_single(action)


func disable_all_actions(disabled : bool):
	_input_box.set_disabled_all(disabled)


# TODO add code to disable input for buttons if stats are not enough

func set_card(card_slot : int, card: Card):
	match(card_slot):
		Game.PlayerAction.ACTION_CARD_1:
			_action_card_1.texture = card.get_image()
			_action_card_1.disabled = false
		Game.PlayerAction.ACTION_CARD_2:
			_action_card_2.texture = card.get_image()
			_action_card_2.disabled = false
		Game.PlayerAction.ABILITY_CARD:
			_ability_card.texture = card.get_image()
			_ability_card.disabled = false



# Signal Binds

# ###### 
##################
## TODO make take pan selection input
##############

func _on_light_attack():
	_input_box.set_disabled_all(true)
	emit_signal("action_input", Game.PlayerAction.ATTACK_LIGHT)


func _on_heavy_attack():
	_input_box.set_disabled_all(true)
	emit_signal("action_input", Game.PlayerAction.ATTACK_HEAVY)


func _on_play_card():
	_card_select.set_hidden(false)
	_input_box.set_hidden(true)

func _on_potion():
	_input_box.set_disabled_all(true)
	emit_signal("action_input", Game.PlayerAction.POTION)
	

func _on_skip_turn():
	_input_box.set_disabled_all(true)
	emit_signal("action_input", Game.PlayerAction.SKIP_PAWN)


func _on_select_exit():
	_card_select.set_hidden(true)
	_input_box.set_hidden(false)


func _on_card_select(card_slot : int):
	_input_box.set_disabled_all(true)
	emit_signal("action_input", card_slot)
	_card_select.set_hidden(true)
	_input_box.set_hidden(false)


signal action_input(action, target_pawn)

signal potion_input(potion, target_pawn)
			


#110x79
