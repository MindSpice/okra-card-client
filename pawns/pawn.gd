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

# For internal use
var _home_pos: Vector2
var _state : int
var _speed : int = 1000
var _velocity : Vector2 = Vector2.ZERO
var _target_pos : Vector2
var _target_pawn : int
var _menu : Node

# Game Variables
var pawn_idx : int
var is_player : bool
var is_dead : bool
var is_active : bool
var stats : StatMap = StatMap.new(0,0,0,0,0,0)
var effects : Array
const cards = {
	Game.CardSlot.PAWN_CARD		: "",
	Game.CardSlot.WEAPON_CARD 	: "",
	Game.CardSlot.ACTION_CARD_1	: "",
	Game.CardSlot.ACTION_CARD_2	: "",
	Game.CardSlot.ABILITY_CARD	: "",
	Game.CardSlot.POWER_CARD	: ""
}





func _ready():
	self.hide()


func init_data(pawn_idx: int, is_player : bool) -> void:
	_home_pos = Game.P_PAWN_POS[pawn_idx] if is_player else Game.E_PAWN_POS[pawn_idx]
	position = _home_pos
	self.pawn_idx = pawn_idx
	self.is_player = is_player
	_menu = _combat_menu.instance() if is_player else _enemy_menu.instance()
	_detection_box.is_player = is_player
	_detection_box.pawn_idx = pawn_idx
	
	_sprite.scale = Vector2(-1.5, 1.5) if is_player else Vector2(1.5, 1.5)
	
	if is_player: 
		$DetectionBox/Area.position.x = 40
		_menu = _combat_menu.instance()
		_menu.set_position(Vector2(Game.P_PAWN_POS[pawn_idx].x + 160, Game.P_PAWN_POS[pawn_idx].y - 110))
		_gui.add_child(_menu)
		_menu.connect("action_input", self, "_on_action_input")
	else:
		_menu = _enemy_menu.instance()
		_menu.set_position(Vector2(Game.E_PAWN_POS[pawn_idx].x - 290, Game.E_PAWN_POS[pawn_idx].y - 110))
		_gui.add_child(_menu)
	self.show()
	_state = Game.PState.IDLE

func init_hooks(net : NetHook, gui : Node):
	_net = net
	_gui = gui

###########
## LOGIC ##
###########

func calc_valid_actions():
	#todo calculate if pawn has enough stats to do actions
	pass

func set_active(active : bool):
	is_active = active
	_menu.disabled_all_actions(false if active else true)
	



##############################
## NETWORK INCOMING UPDATES ##
##############################

func update_stats(stat_update : Dictionary):
	stats.set_all(stat_update)
	_menu.set_stats(stat_update)
	#calc_valid_actions

	# TODO disable input options if tstats are too low for them


func update_effects(effects_update : Array):
	effects = effects_update
	_menu.set_effects(effects_update)
	#calc_valid_actions
	#calc if incoming effect disable a turn (reflects, or chaos self hits)


func turn_reponse(response : NetTurnResponse):
	# Disable Card if Card, Makes redundant call if button, 
	# But cards only reenable on card updates, buttons on turn, could use better syntax
	_menu.disable_action(response.turn_action)

	# TODO
	# Init animation
	# Show Action Flags

# Free's obj, updates pawn card, then nulls img reference and updates input menu
# Some redundant void calls to set_card, but less syntax
func card_hand_update(update : Dictionary):
	for card in cards:
		card.queue_free()
	for card in update:
		cards[card] = update.get(card)
		_menu.set_card(card, update.get(card))


func set_dead():
	is_dead = true
	is_active = false



func turn_update(active : bool):
	set_active(active)
	#calc_valid_actions








######################
## NETWORK OUTGOING ##
######################

func _on_action_input(action, target_pawn):
	var nga = NetGameAction.new(
		action,
		pawn_idx,
		target_pawn,
		"null"
	)
	_net.send(nga)




func _on_potion_input():
	pass





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
