extends Node2D

#  Pawn States
var _player_pawns : Array
var _enemy_pawns : Array


# GUI
var _pawn_base := preload("res://pawns/pawn.tscn")
onready var _pawn_view := $PawnSort
onready var _gui := $GUI

# Game Vars
var is_player_turn : bool
var turn_active_pawns : Array

# Net Relay
var _net : NetHook = NetHook.new()


func _ready() -> void:
	_net.connect("dead_update", self, "_on_dead_update")
	_net.connect("effect_update", self, "_on_effect_update")
	_net.connect("game_over", self, "_on_game_over")
	_net.connect("insight_update", self, "on_insight_update")
	_net.connect("stat_update", self, "_on_stat_update")
	_net.connect("turn_response", self, "_on_turn_response")
	_net.connect("turn_update", self, "on_turn_update")
	_net.connect("card_update", self, "on_card_update")

	var s = {
		Game.StatType.HP: 1111,
		Game.StatType.DP: 2222,
		Game.StatType.SP: 3333,
		Game.StatType.MP: 4444,
		Game.StatType.WILLPOWER: 5555,
		Game.StatType.LUCK: 6666
	}
	var e = [
		"PARALYSIS","POISON","CONFUSION","INSIGHT_STATUS","DEMEDITATE","INVIGORATE","FORTUNE","MISFORTUNE","PARALYSIS","POISON","CONFUSION","INSIGHT_STATUS","DEMEDITATE","INVIGORATE","FORTUNE"
	]
	


	for i in 3:
		var p_pawn := _pawn_base.instance()
		_player_pawns.append(p_pawn)
		_pawn_view.add_child(p_pawn)
		p_pawn.init_hooks(_net, _gui)
		p_pawn.init_data(i, true)
		p_pawn.update_stats(s)
		p_pawn.update_effects(e)
		
	for i in 3:
		var e_pawn := _pawn_base.instance()
		_enemy_pawns.append(e_pawn)
		_pawn_view.add_child(e_pawn)
		e_pawn.init_hooks(_net, _gui)
		e_pawn.init_data(i, false)
		e_pawn.update_stats(s)
		e_pawn.update_effects(e)


#TODO add function to init pawn set
	
######################
## Helper Functions ##
######################

# Could referrence array directly, but this is a little more "fool proof" and lessens if checks
func get_pawn(pawn_idx : int, is_player : bool) -> Node:
		return _player_pawns[pawn_idx] if is_player else _enemy_pawns[pawn_idx]


func _on_Button_pressed() -> void:
	var s = {
		Game.StatType.HP: 666
	}
	get_pawn(1, false).update_stats(s)
	if randf() > .5:
		_player_pawns[randi() % 3].lunge(randi() % 3)
	else:
		_enemy_pawns[randi() % 3].lunge(randi() % 3)

				
#########################
## NET UPDATE HANDLERS ##
#########################

func _on_dead_update(dead : NetDead):
	var pawn : Node = get_pawn(dead.pawn_index, dead.is_player)
	pawn.is_dead = true
	
	
func _on_effect_update(effects : NetEffect):
	get_pawn(Game.Pawn.PAWN1, true).effects = effects.pawn_1
	get_pawn(Game.Pawn.PAWN2, true).effects = effects.pawn_2
	get_pawn(Game.Pawn.PAWN3, true).effects = effects.pawn_3


func _on_game_over(game_over : NetGameOver):
	if game_over.is_player:
		# display
		pass
	else:
		#display
		pass


func _on_insight(insight : NetInsight):
	pass


func _on_stat_update(stat : NetStat):
	get_pawn(Game.Pawn.PAWN1, true).stats.set_all(stat.pawn_1)
	get_pawn(Game.Pawn.PAWN2, true).stats.set_all(stat.pawn_2)
	get_pawn(Game.Pawn.PAWN3, true).stats.set_all(stat.pawn_3)


func _on_turn_response(response : NetTurnResponse):
	if response.is_player:
		pass
		#Handle animation metrics and display action flags if relevent
	else:
		pass


func _on_turn_update(turn : NetTurnUpdate):
	if turn.is_player:
		is_player_turn = true
		turn_active_pawns = turn.active_pawns
		

func _on_card_update(cards : NetCardUpdate):
	pass





