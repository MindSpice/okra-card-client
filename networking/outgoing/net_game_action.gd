extends Reference

class_name NetGameAction

var action : String
var player_pawn : String
var target_pawn : String
var potion : String


func _init(action : String, player_pawn : String, target_pawn : String, potion: String) -> void:
	self.action = action
	self.player_pawn = player_pawn
	self.target_pawn = target_pawn
	self.potion = potion

