extends Reference

class_name PawnSet
var set_name : String
var power_deck : Array
var preferred_potions : Array
var pawn_loadouts : Array
var set_number := -1

var test : Dictionary = {"PAWN1":{"ability_deck":["FIVE","FOUR","SEVEN","THREE","NINE","ONE"],"action_deck":["FIVE","ONE","TWO","FIVE","THREE"],"pawn_card":"PAWN1","weapon_card":"WEAPON2"},"PAWN2":{"ability_deck":["TWO","TEN","FIVE","FOUR","SEVEN"],"action_deck":["SEVEN","SEVEN","EIGHT","SEVEN"],"pawn_card":"PAWN3","weapon_card":"WEAPON2"},"PAWN3":{"ability_deck":["TEN","EIGHT","THREE","NINE","ONE","EIGHT","TWO"],"action_deck":["NINE","NINE","TEN","TEN","NINE","TEN"],"pawn_card":"PAWN1","weapon_card":"WEAPON3"},"power_deck":["EIGHT","TWO","TEN","FIVE","FOUR","SEVEN","THREE","NINE"],"preferred_potions":["POTION1","POTION2","POTION3"],"set_name":"Test_Set"}
func _init():
	for i in 3:
		pawn_loadouts.append(PawnLoadout.new())

		
func load(set : Dictionary) -> void:
	set_name = set.get("name")
	power_deck = CardBase.instance_card_list(Game.Domain.POWER, set.get("powerHand"))
	preferred_potions = set.get("preferredPotions")

	var pawns = set.get("pawns")
	for i in range(0, pawns.size()):
		pawn_loadouts[i].load(pawns[i])


func is_valid() -> bool:
	if pawn_loadouts.size() < 3:
		return false
		
	for pawn in pawn_loadouts:
		if not pawn.is_valid():
			return false
	
	if power_deck.size() > Game.POWER_MAX or power_deck.size() < Game.POWER_MIN:
		return false	
		
	return true
	
	
func get_as_dict() -> Dictionary:
	if not is_valid():
		push_error("Invalid PawnSet")
		#return {}
	
	return {
		"name" : set_name,
		"powerHand" : CardBase.card_nodes_as_names(power_deck),
		"potions" 	: preferred_potions,
		"pawns"		: [pawn_loadouts[0].get_as_dict(), pawn_loadouts[1].get_as_dict(), pawn_loadouts[2].get_as_dict()]

	}
	
func clean_up() -> void:
	for pl in pawn_loadouts:
		pl.clean_up()
	Util.free_array(power_deck)
	
	
func get_all_card_names(domain :int) -> Array:
	if domain == Game.Domain.POWER:
		return CardBase.card_nodes_as_names(power_deck)
		
	var cards : Array
	
	
	match(domain):
		Game.Domain.PAWN:
			for pl in pawn_loadouts:
				cards.append(pl.pawn_card.card_name)
		Game.Domain.WEAPON:
			for pl in pawn_loadouts:
				cards.append(pl.weapon_card_1.card_name)
				cards.append(pl.weapon_card_2.card_name)
		Game.Domain.ACTION:
			for pl in pawn_loadouts:
				cards.append_array(CardBase.card_nodes_as_names(pl.action_deck))
		Game.Domain.ABILITY:
			for pl in pawn_loadouts:
				cards.append_array(CardBase.card_nodes_as_names(pl.ability_deck))
		Game.Domain.TALISMAN:
			for pl in pawn_loadouts:
				cards.append(pl.talisman_card.card_name)

	return cards
	
	
# Horrible O(N^4) function, really wish I could use streams
# Can't think of a better way atm, could be made N^3 keeping index and not using erase
# But thats even more lines..... Not a big deal since array sizes are so small..I guess
func remove_invalids(domain : int, invalids : Array) -> void:
	if domain == Game.Domain.POWER:
		for invalid in invalids:
			for card in power_deck:
				if card.card_name == invalid:
					card.queue_free()
					power_deck.erase(card)
					break
	match (domain):
		Game.Domain.PAWN:
			for invalid in invalids:
				for pl in pawn_loadouts:
					if pl.pawn_card == null:
						 continue
					if pl.pawn_card.card_name == invalid:
						pl.pawn_card.queue_free()
						pl.pawn_card = null
		Game.Domain.TALISMAN:
			for invalid in invalids:
				for pl in pawn_loadouts:
					if pl.talisman_card == null:
						continue
					if pl.talisman_card.card_name == invalid:
						pl.talisman_card.queue_free()
						pl.talisman_card = null	
		Game.Domain.WEAPON:
			for invalid in invalids:
				for pl in pawn_loadouts:
					if pl.weapon_card_1 != null:
						if pl.weapon_card_1.card_name == invalid:
							pl.weapon_card_1.queue_free()
							pl.weapon_card_1 = null
							
					if pl.weapon_card_2 != null:
						if pl.weapon_card_2.card_name == invalid:
							pl.weapon_card_2.queue_free()
							pl.weapon_card_2 = null					
		Game.Domain.ACTION:
			for invalid in invalids:
				for pl in pawn_loadouts:
					for card in pl.action_deck:
						if card.card_name == invalid:
							pl.action_deck.erase(card)
							card.queue_free()
							continue
		Game.Domain.ABILITY:
			for invalid in invalids:
				for pl in pawn_loadouts:
					for card in pl.ability_deck:
						if card.card_name == invalid:
							pl.ability_deck.erase(card)
							card.queue_free()
							continue

