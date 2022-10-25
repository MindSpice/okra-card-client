extends KinematicBody2D

onready var sprite : Sprite = $Sprite
onready var detection_box : Area2D = $DetectionBox
onready var animation_player : AnimationPlayer = $AnimationPlayer

# For internal move/amination calculations
var pawn_idx : int
var home_pos: Vector2
var is_player : bool
var is_dead : bool
var state : int
var speed : int = 1000
var velocity : Vector2 = Vector2.ZERO
var target_pos : Vector2
var target_pawn : int

# Stats
var stats : StatMap
var effects : Array

# Cards
var action_card_1 : Card
var action_card_2 : Card
var ability_card : Card
var power_card : Card


func _ready():
	self.hide()

#TODO later make a pawn factor and init with animation + sprite, or make seperate scenes?
# Need to make modular to some extent, componentize attack etc.
func init(pawn_idx: int, is_player : bool) -> void:
	home_pos = Game.P_PAWN_POS[pawn_idx] if is_player else Game.E_PAWN_POS[pawn_idx]
	position = home_pos
	self.is_player = is_player
	detection_box.is_player = is_player
	detection_box.pawn_idx = pawn_idx
	
	sprite.scale = Vector2(-1.5, 1.5) if is_player else Vector2(1.5, 1.5)
	
	if is_player: 
		$DetectionBox/Area.position.x = 40
	self.show()
	state = Game.PState.IDLE



func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	match(state):
		Game.PState.IDLE:
			animation_player.play("Idle")
			
		Game.PState.LUNGE:
			animation_player.play("Lunge")
			velocity = position.direction_to(target_pos) * speed
			
			if position.direction_to(target_pos).x < 15:
				velocity = move_and_slide(velocity)
			else:
				state = Game.PState.RESET
				
		Game.PState.ATTACK:
			animation_player.play("Attack")
			
		Game.PState.DEFEND:
			animation_player.play("Block")
			
		Game.PState.RESET:
			animation_player.play("Idle")
			velocity = position.direction_to(home_pos) * speed
			if abs(position.x - home_pos.x) > 5:
				velocity = move_and_slide(velocity)
			else:
				state = Game.PState.IDLE
				
func lunge(pawn_idx : int):
	state = Game.PState.LUNGE
	target_pos = Game.E_PAWN_POS[pawn_idx] if is_player else Game.P_PAWN_POS[pawn_idx]
	target_pawn = pawn_idx
	
	
func _on_DetectionBox_entered(area: Area2D) -> void:
	
	if is_player == area.is_player:
		return
	
#	if state != Game.PState.IDLE and area.pawn_idx != target_pawn:
#		print("not target")
#		return
	
	if state == Game.PState.IDLE:
		state = Game.PState.DEFEND
	
		
	elif state == Game.PState.LUNGE:
		state = Game.PState.ATTACK

func _on_attack_end() -> void:
	state = Game.PState.RESET
	
func _on_block_end() -> void:
	state = Game.PState.IDLE
	
func _set_dead():
	is_dead = true;
	#death animation
