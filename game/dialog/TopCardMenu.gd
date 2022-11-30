extends PanelContainer


onready var pawn1_card_img := {
	Game.CardSlot.PAWN_CARD			: $TabContainer/Pawn/VBox/Pawn1/Pawn,
	Game.CardSlot.WEAPON_CARD		: $TabContainer/Pawn/VBox/Pawn1/Weapon,
	Game.CardSlot.ACTION_CARD_1		: $TabContainer/Cards/VBox/Pawn1/Action1,
	Game.CardSlot.ACTION_CARD_2		: $TabContainer/Cards/VBox/Pawn1/Action2,
	Game.CardSlot.ABILITY_CARD		: $TabContainer/Cards/VBox/Pawn1/Ability,
	Game.CardSlot.POWER_CARD		: $TabContainer/Pawn/VBox/Pawn1/Power,
}

onready var pawn2_card_img := {
	Game.CardSlot.PAWN_CARD			: $TabContainer/Pawn/VBox/Pawn2/Pawn,
	Game.CardSlot.WEAPON_CARD		: $TabContainer/Pawn/VBox/Pawn2/Weapon,
	Game.CardSlot.ACTION_CARD_1		: $TabContainer/Cards/VBox/Pawn2/Action1,
	Game.CardSlot.ACTION_CARD_2		: $TabContainer/Cards/VBox/Pawn2/Action2,
	Game.CardSlot.ABILITY_CARD		: $TabContainer/Cards/VBox/Pawn2/Ability,
	Game.CardSlot.POWER_CARD		: $TabContainer/Pawn/VBox/Pawn2/Power,
}

onready var pawn3_card_img := {
	Game.CardSlot.PAWN_CARD			: $TabContainer/Pawn/VBox/Pawn3/Pawn,
	Game.CardSlot.WEAPON_CARD		: $TabContainer/Pawn/VBox/Pawn3/Weapon,
	Game.CardSlot.ACTION_CARD_1		: $TabContainer/Cards/VBox/Pawn3/Action1,
	Game.CardSlot.ACTION_CARD_2		: $TabContainer/Cards/VBox/Pawn3/Action2,
	Game.CardSlot.ABILITY_CARD		: $TabContainer/Cards/VBox/Pawn3/Ability,
	Game.CardSlot.POWER_CARD		: $TabContainer/Pawn/VBox/Pawn3/Power,
}


func _ready():
	pass


func set_card(pawn : int, card_slot : int, img : Resource) -> void:
	match(pawn):
		Game.Pawn.PAWN1:
			var card = pawn1_card_img.get(card_slot)
			card.texture = img
		Game.Pawn.PAWN2:
			var card = pawn2_card_img.get(card_slot)
			card.texture = img
		Game.Pawn.PAWN3:
			var card = pawn3_card_img.get(card_slot)
			card.texture = img
