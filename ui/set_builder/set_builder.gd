extends Control

var action_cards_free : Array
var ability_cards_free : Array
var power_cards_free : Array
var pawn_cards_free : Array
var weapon_cards_free : Array

var set_name : String
var power_deck : Array
var pawn_loadouts : Array


onready var deck_builder :  = preload("res://ui/deck_builder/deck_builder.tscn")
onready var pawn_select :  = preload("res://ui/set_builder/pawn_select.tscn").instance()



func _ready():
	action_cards_free = Player.action_cards_all.duplicate(true)
	ability_cards_free = Player.ability_cards_all.duplicate(true)
	power_cards_free = Player.power_cards_all.duplicate(true)
	pawn_cards_free = Player.pawn_cards_all.duplicate(true)
	weapon_cards_free = Player.weapon_cards_all.duplicate(true)
	
	$Panel.add_child(pawn_select)
	pawn_select.set_card_grid(Game.Domain.ACTION, action_cards_free)
	pawn_select.pop_up()
	



func _set_pawn_loadout(pawn_idx : int, pawn_loadout : PawnLoadout):
	match(pawn_idx):
		Game.Pawn.PAWN1:
			pawn_loadouts[0] = pawn_loadout
		Game.Pawn.PAWN2:
			pawn_loadouts[1] = pawn_loadout
		Game.Pawn.PAWN3:
			pawn_loadouts[2] = pawn_loadout


func _get_pawn_loadout(pawn_idx : int) -> PawnLoadout:
	match(pawn_idx):
		Game.Pawn.PAWN1:
			return pawn_loadouts[0]
		Game.Pawn.PAWN2:
			return pawn_loadouts[1]
		Game.Pawn.PAWN3:
			return pawn_loadouts[2]
	return null

	
	


# These are pass an int that is indexed the same as
# Game.Pawn enum, ex. 0 = PAWN1, and are thus interchangeable 

func _on_SelectPawn_pressed(pawn_idx : int):
	#_get_pawn_loadout(pawn_idx).pawn_card
	pass


func _on_SelectWeapon_pressed(pawn_idx : int):
	pass # Replace with function body.


func _on_BuildAttack_pressed(pawn_idx : int):
	var db : Node = deck_builder.instance()
	db.init(Game.Domain.ACTION, action_cards_free)
	$HSplit.hide()
	$Panel.add_child(db)
	#todo connect signal
	
	
func _on_BuildAbility_pressed(pawn : int):
	pass # Replace with function body.


func _on_To_Menu_pressed():
	get_tree().change_scene("res://ui/menu/menu.tscn")
