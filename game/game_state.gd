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
var _net : NetHook


func _ready() -> void:
	_net = NetHook.new()
	_net.connect("dead_update", self, "_on_dead_update")
	_net.connect("effect_update", self, "_on_effect_update")
	_net.connect("game_over", self, "_on_game_over")
	_net.connect("insight_update", self, "_on_insight_update")
	_net.connect("stat_update", self, "_on_stat_update")
	_net.connect("turn_response", self, "_on_turn_response")
	_net.connect("turn_update", self, "_on_turn_update")
	_net.connect("card_update", self, "_on_card_update")

	#test
	Network.init_wss_conn("123")

	

	for i in 3:
		var p_pawn := _pawn_base.instance()
		_player_pawns.append(p_pawn)
		_pawn_view.add_child(p_pawn)
		p_pawn.init_hooks(_net, _gui)
		p_pawn.init_data(i, true)


		
	for i in 3:
		var e_pawn := _pawn_base.instance()
		_enemy_pawns.append(e_pawn)
		_pawn_view.add_child(e_pawn)
		e_pawn.init_hooks(_net, _gui)
		e_pawn.init_data(i, false)




#TODO add function to init pawn set
	
######################
## Helper Functions ##
######################

# Could referrence array directly, but this is a little more "fool proof" and lessens if checks
func get_pawn(pawn_idx : int, is_player : bool) -> Node:
		return _player_pawns[pawn_idx] if is_player else _enemy_pawns[pawn_idx]


func _on_Button_pressed() -> void:
	_net.send(NetGameAction.new(0,1,2,""))
	# if randf() > .5:
	# 	_player_pawns[randi() % 3].lunge(randi() % 3)
	# else:
	# 	_enemy_pawns[randi() % 3].lunge(randi() % 3)

				
#########################
## NET UPDATE HANDLERS ##
#########################

func _on_dead_update(dead : NetDead):
	var pawn : Node = get_pawn(dead.pawn_index, dead.is_player)
	pawn.set_dead()
	
	
func _on_effect_update(effects : NetEffect):
	for pawn in effects.pawn_effects:
		get_pawn(pawn, effects.is_player).update_effects(effects.pawn_effects.get(pawn))


func _on_game_over(game_over : NetGameOver):
	if game_over.is_player:
		# display
		pass
	else:
		#display
		pass


func _on_insight(insight : NetInsight):
	pass


func _on_stat_update(stats : NetStat):
	for pawn in stats.pawn_stats:
		get_pawn(pawn, stats.is_player).update_stats(stats.pawn_stats.get(pawn))


func _on_turn_response(response : NetTurnResponse):
	#todo, likely will need  to handle animations from here to access both player and enemy
	get_pawn(response.player_pawn, response.is_player).turn_response(response)


func _on_turn_update(turn : NetTurnUpdate):
	if turn.is_player == false:
		# Turn gfx
		for pawn in _player_pawns:
			pawn.turn_update(false)
	else:
		for pawn in turn.pawn_turns:
			get_pawn(pawn, true).turn_update(turn.pawn_turns.get(pawn))
		

func _on_card_update(cards : NetCardUpdate):
	for pawn in cards.pawn_cards:
		get_pawn(pawn, cards.is_player).card_hand_update(cards.pawn_cards.get(pawn))
	
