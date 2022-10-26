extends KinematicBody2D

class_name Pawn

# Resources
var _combat_menu := preload("res://game/dialog/combat_menu.tscn")
var _enemy_menu := preload("res://game/dialog/enemy_menu.tscn")
var _net : NetHook
var _gui : Node
onready var _sprite : Sprite = $Sprite
onready var _detection_box : Area2D = $DetectionBox
onready var _animation_player : AnimationPlayer = $AnimationPlayer

# For internal move/amination calculations
var _home_pos: Vector2
var _state : int
var _speed : int = 1000
var _velocity : Vector2 = Vector2.ZERO
var _target_pos : Vector2
var _target_pawn : int

# Game Variables
var pawn_idx : int
var is_player : bool
var is_dead : bool
var stats : StatMap = StatMap.new(0,0,0,0,0,0)
var effects : Array

# Cards
var _action_card_1 : Card
var _action_card_2 : Card
var _ability_card : Card
var _power_card : Card

var menu : Node


func _ready():
	self.hide()


func init_data(pawn_idx: int, is_player : bool) -> void:
	_home_pos = Game.P_PAWN_POS[pawn_idx] if is_player else Game.E_PAWN_POS[pawn_idx]
	position = _home_pos
	self.pawn_idx = pawn_idx
	self.is_player = is_player
	self.menu = menu
	_detection_box.is_player = is_player
	_detection_box.pawn_idx = pawn_idx
	
	_sprite.scale = Vector2(-1.5, 1.5) if is_player else Vector2(1.5, 1.5)
	
	if is_player: 
		$DetectionBox/Area.position.x = 40
		menu = _combat_menu.instance()
		menu.set_position(Vector2(Game.P_PAWN_POS[pawn_idx].x + 160, Game.P_PAWN_POS[pawn_idx].y - 110))
		_gui.add_child(menu)
		menu.connect("action_input", self, "_on_action_input")
	else:
		menu = _enemy_menu.instance()
		menu.set_position(Vector2(Game.E_PAWN_POS[pawn_idx].x - 290, Game.E_PAWN_POS[pawn_idx].y - 110))
		_gui.add_child(menu)
	self.show()
	_state = Game.PState.IDLE

func init_hooks(net : NetHook, gui : Node):
	_net = net
	_gui = gui



###########################
## INTERACTION & UPDATES ##
############################

func update_stats(stat_update : Dictionary):
	stats.set_all(stat_update)
	menu.set_stats(stat_update)

	# TODO disable input options if tstats are too low for them


func update_effects(effects_update : Array):
	effects = effects_update
	menu.set_effects(effects_update)

func _on_action_input(action):
	print(pawn_idx, "|", action)





############################
## GAME LOGIC & ANIMATION ##
############################

func _physics_process(delta: float) -> void:
	match(_state):
		Game.PState.IDLE:
			_animation_player.play("Idle")
			
		Game.PState.LUNGE:
			_animation_player.play("Lunge")
			_velocity = position.direction_to(_target_pos) * _speed
			
			if position.direction_to(_target_pos).x < 15:
				_velocity = move_and_slide(_velocity)
			else:
				_state = Game.PState.RESET
				
		Game.PState.ATTACK:
			_animation_player.play("Attack")
			
		Game.PState.DEFEND:
			_animation_player.play("Block")
			
		Game.PState.RESET:
			_animation_player.play("Idle")
			_velocity = position.direction_to(_home_pos) * _speed
			if abs(position.x - _home_pos.x) > 5:
				_velocity = move_and_slide(_velocity)
			else:
				_state = Game.PState.IDLE
				
func lunge(pawn_idx : int):
	_state = Game.PState.LUNGE
	_target_pos = Game.E_PAWN_POS[pawn_idx] if is_player else Game.P_PAWN_POS[pawn_idx]
	_target_pawn = pawn_idx
	
	
func _on_DetectionBox_entered(area: Area2D) -> void:
	
	if is_player == area.is_player:
		return
#	if state != Game.PState.IDLE and area.pawn_idx != target_pawn:
#		print("not target")
#		return
	if _state == Game.PState.IDLE:
		_state = Game.PState.DEFEND

	elif _state == Game.PState.LUNGE:
		_state = Game.PState.ATTACK


func _on_attack_end() -> void:
	_state = Game.PState.RESET
	

func _on_block_end() -> void:
	_state = Game.PState.IDLE
	

func _set_dead():
	is_dead = true;
	#death animation
