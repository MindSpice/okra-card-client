extends Node2D

var _player_pawns : Array
var _enemy_pawns : Array
var _pawn_base := preload("res://pawns/pawn.tscn")
var _combat_menu := preload("res://gameview/dialog/combat_menu.tscn")
var _enemy_menu := preload("res://gameview/dialog/enemy_menu.tscn")
onready var _pawn_view := $PawnSort
onready var _control_layer := $CanvasLayer



func _ready() -> void:
	for i in 3:
		var p_pawn := _pawn_base.instance()
		_player_pawns.append(p_pawn)
		_pawn_view.add_child(p_pawn)
		p_pawn.init(i, true)
		var cm = _combat_menu.instance()
		cm.set_position(Vector2(Game.P_PAWN_POS[i].x + 160, Game.P_PAWN_POS[i].y - 110))
		_control_layer.add_child(cm)
		cm.show()
		
	for i in 3:
		var e_pawn := _pawn_base.instance()
		_enemy_pawns.append(e_pawn)
		_pawn_view.add_child(e_pawn)
		e_pawn.init(i, false)
		var em = _enemy_menu.instance()
		em.set_position(Vector2(Game.E_PAWN_POS[i].x - 290, Game.E_PAWN_POS[i].y - 110))
		_control_layer.add_child(em)
		em.show()
	

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

