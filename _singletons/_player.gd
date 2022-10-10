extends Node



var ability_cards_all : Array 
var action_cards_all : Array
var power_cards_all : Array
var pawn_cards_all : Array
var weapon_cards_all : Array
var pawn_sets : Array
var potions : Dictionary

var okra_tokens : float = 0

func _ready(): 
	action_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	ability_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	power_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	pawn_cards_all = ["PAWN1","PAWN1", "PAWN2", "PAWN2", "PAWN3", "PAWN3"]
	
	weapon_cards_all = [ "WEAPON1", "WEAPON1", "WEAPON2", "WEAPON2", "WEAPON3", "WEAPON3"]
