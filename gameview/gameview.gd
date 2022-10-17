extends Control

var _player_pawns : Array
var _enemy_pawns : Array
var _pawn_base := preload("res://pawns/pawn.tscn")
onready var viewport := $VBox/Hbox/ViewPort/PawnSort


func _ready() -> void:
	for i in 3:
		var p_pawn := _pawn_base.instance()
		_player_pawns.append(p_pawn)
		viewport.add_child(p_pawn)
		p_pawn.init(Game.P_PAWN_POS[i], true)
	for i in 3:
		var e_pawn := _pawn_base.instance()
		_enemy_pawns.append(e_pawn)
		viewport.add_child(e_pawn)
		e_pawn.init(Game.E_PAWN_POS[i], false)
	_player_pawns[1].lunge(Game.E_PAWN_POS[1])

func get_pawn(pawn_idx : int, is_player : bool) -> Node:
	if is_player:
		return _player_pawns[pawn_idx]
	else:
		return _enemy_pawns[pawn_idx]

