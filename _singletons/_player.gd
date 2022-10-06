extends Node



var ability_cards_all : Array 
onready var action_cards_all : Array
var power_cards_all : Array
var action_decks : Dictionary
var ability_decks : Dictionary
var power_decks : Dictionary
var pawns : Dictionary
var potions : Dictionary

var okra_tokens : float = 0

func _ready(): 
	action_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	ability_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	power_cards_all = ["ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", 
	"EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE","ONE", "EIGHT", "TWO", "TEN", "FIVE", "FOUR", "SEVEN", "THREE", "NINE"]
	
	
	







