extends Node2D

var _player_pawns : Array
var _enemy_pawns : Array
var _pawn_base := preload("res://pawns/pawn.tscn")
onready var viewport := $PawnSort


func _ready() -> void:
	for i in 3:
		var p_pawn := _pawn_base.instance()
		_player_pawns.append(p_pawn)
		viewport.add_child(p_pawn)
		p_pawn.init(i, true)
	for i in 3:
		var e_pawn := _pawn_base.instance()
		_enemy_pawns.append(e_pawn)
		viewport.add_child(e_pawn)
		e_pawn.init(i, false)
	

func get_pawn(pawn_idx : int, is_player : bool) -> Node:
	if is_player:
		return _player_pawns[pawn_idx]
	else:
		return _enemy_pawns[pawn_idx]





func _on_Button_pressed() -> void:
	if randf() > .5:
		_player_pawns[randi() % 3].lunge(randi() % 3)
	else:
		_enemy_pawns[randi() % 3].lunge(randi() % 3)

