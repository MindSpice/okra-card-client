extends Control

# TODO? IDK why I started this with multiple arrays, can be a dictionary with enum keys
var _action_cards_free : Array
var _ability_cards_free : Array
var _power_cards_free : Array
var _pawn_cards_free : Array
var _weapon_cards_free : Array
var _talisman_cards_free: Array
var _saved_pawn_sets : Dictionary 
var _potion_options : Array
var _pawn_set : PawnSet
var set_name: String
var _net = Network


onready var _deck_builder := preload("res://ui/deck_builder/deck_builder.tscn").instance()
onready var _s_select := preload("res://ui/set_builder/pawn_select.tscn").instance()
onready var _dialog := preload("res://ui/simple_dialog.tscn").instance()
onready var _confirm := preload("res://ui/confirm_dialog.tscn").instance()
onready var _replace := preload("res://ui/replace_set.tscn").instance()
onready var _load := preload("res://ui/replace_set.tscn").instance()

func _ready():


	# REMOVE TEST VAR
	_net.init_wss_conn("123")


	_load_cards_all()
	$Panel.add_child(_s_select)
	$Panel.add_child(_deck_builder)
	$Panel.add_child(_dialog)
	$Panel.add_child(_confirm)
	$Panel.add_child(_replace)
	$Panel.add_child(_load)
	_deck_builder.hide()
	_s_select.connect("_card_relay", self, "_set_single_card_selction")
	_deck_builder.connect("closed", self, "_on_deck_builder_close")
	_deck_builder.connect("save", self, "_on_deck_builder_save")
	_replace.connect("confirmed", self, "_on_replace_confirmed")
	_load.connect("confirmed", self, "_on_load_confirmed")
	_add_card_context()
	
	for node in $HSplit/VSplit2/SetInfo/HBox/Potions.get_children():
		if node is OptionButton:
			_potion_options.append(node)
			node.add_item("None")
			for potion in CardBase.POTIONS.keys():
				node.add_item(potion)

	_pawn_set = PawnSet.new()
	Network.connect("set_response", self, "_on_save_response")


func _load_cards_all() -> void:
	_action_cards_free = CardBase.instance_card_list(Game.Domain.ACTION, Player._action_cards_all)
	_ability_cards_free = CardBase.instance_card_list(Game.Domain.ABILITY, Player._ability_cards_all)
	_power_cards_free = CardBase.instance_card_list(Game.Domain.POWER, Player._power_cards_all)
	_pawn_cards_free = CardBase.instance_card_list(Game.Domain.PAWN, Player._pawn_cards_all)
	_weapon_cards_free = CardBase.instance_card_list(Game.Domain.WEAPON, Player._weapon_cards_all)
	_talisman_cards_free = CardBase.instance_card_list(Game.Domain.TALISMAN, Player._talisman_cards_all)


func _clear_cards_all() -> void:
	_pawn_set.clean_up()
	Util.free_array(_pawn_cards_free)
	Util.free_array(_weapon_cards_free)
	Util.free_array(_action_cards_free)
	Util.free_array(_ability_cards_free)
	Util.free_array(_power_cards_free)
	

func _add_card_context() -> void:
	for card in _action_cards_free:
		card.connect("context_selected", _deck_builder, "update_deck")
		
	for card in _ability_cards_free:
		card.connect("context_selected", _deck_builder, "update_deck")
		
	for card in _power_cards_free:
		card.connect("context_selected", _deck_builder, "update_deck")
	
	for card in _pawn_cards_free:
		card.connect("card_selected", _s_select, "_select_card")

	for card in _weapon_cards_free:
		card.connect("card_selected", _s_select, "_select_card")

	for card in _talisman_cards_free:
		card.connect("card_selected", _s_select, "_select_card")
	

func _set_pawn_loadout(pawn_idx : int, pawn_loadout : PawnLoadout):
	match(pawn_idx):
		Game.Pawn.PAWN1:
			_pawn_set.pawn_loadouts[0] = pawn_loadout
		Game.Pawn.PAWN2:
			_pawn_set.pawn_loadouts[1] = pawn_loadout
		Game.Pawn.PAWN3:
			_pawn_set.pawn_loadouts[2] = pawn_loadout


func _get_pawn_loadout(pawn_idx : int) -> PawnLoadout:
	match(pawn_idx):
		Game.Pawn.PAWN1:
			return _pawn_set.pawn_loadouts[0]
		Game.Pawn.PAWN2:
			return _pawn_set.pawn_loadouts[1]
		Game.Pawn.PAWN3:
			return _pawn_set.pawn_loadouts[2]
	push_error("Wrong Pawn Index")
	return null


func _get_card_window(pawn_idx :int, domain : int, card_idx: int) -> Node:
	match(pawn_idx):
		Game.Pawn.PAWN1:
			match(domain):
				Game.Domain.PAWN:
					return $HSplit/VSplit/Pawn1/VBox/HBox2/Pawn/PawnCard
				Game.Domain.WEAPON:
					if (card_idx == 1):
						return $HSplit/VSplit/Pawn1/VBox/HBox2/Weapon1/WeaponCard1
					else:
						return $HSplit/VSplit/Pawn1/VBox/HBox2/Weapon2/WeaponCard2
				Game.Domain.TALISMAN:
					return $HSplit/VSplit/Pawn1/VBox/HBox2/Talisman/TalismanCard

		Game.Pawn.PAWN2:
			match(domain):
				Game.Domain.PAWN:
					return $HSplit/VSplit2/Pawn2/VBox/HBox2/Pawn/PawnCard
				Game.Domain.WEAPON:
					if (card_idx == 1):
						return $HSplit/VSplit2/Pawn2/VBox/HBox2/Weapon1/WeaponCard1
					else:
						return $HSplit/VSplit2/Pawn2/VBox/HBox2/Weapon2/WeaponCard2
				Game.Domain.TALISMAN:
					return $HSplit/VSplit2/Pawn2/VBox/HBox2/Talisman/TalismanCard

		Game.Pawn.PAWN3:
			match(domain):
				Game.Domain.PAWN:
					return $HSplit/VSplit/Pawn3/VBox/HBox2/Pawn/PawnCard
				Game.Domain.WEAPON:
					if (card_idx == 1):
						return $HSplit/VSplit/Pawn3/VBox/HBox2/Weapon1/WeaponCard1
					else:
						return $HSplit/VSplit/Pawn3/VBox/HBox2/Weapon2/WeaponCard2
				Game.Domain.TALISMAN:
					return $HSplit/VSplit/Pawn3/VBox/HBox2/Talisman/TalismanCard
				
	push_error("Wrong Domain")
	return null

func _get_error_label(pawn_idx: int) -> Node:
	match(pawn_idx):
		0: return $HSplit/VSplit/Pawn1/VBox/HBox3/VBox/error
		1: return $HSplit/VSplit2/Pawn2/VBox/HBox3/VBox/error
		2: return $HSplit/VSplit/Pawn3/VBox/HBox3/VBox/error
	return null


func _get_all_by_domain(domain : int) -> Array:
	match (domain):
		Game.Domain.ACTION:
			return _action_cards_free
		Game.Domain.ABILITY:
			return _ability_cards_free
		Game.Domain.POWER:
			return _power_cards_free
		Game.Domain.PAWN:
			return _pawn_cards_free
		Game.Domain.WEAPON:
			return _weapon_cards_free
		Game.Domain.TALISMAN:
			return _talisman_cards_free
	
	push_error("Bad Domain Index")
	return []


func _remove_from_free(domain : int, card : Card) -> void:
	if card == null:
		return
	_get_all_by_domain(domain).erase(card)


func _replace_to_free(domain : int, card : Card):
	if card == null:
		return
	_get_all_by_domain(domain).append(card)


func _set_single_card_selction(pawn_idx : int, domain : int, card : Card, card_idx: int) -> void:
	if card == null:
		return
		
	match (domain):
		Game.Domain.PAWN:
			_replace_to_free(domain, _get_pawn_loadout(pawn_idx).pawn_card)
			_remove_from_free(domain, card)
			_get_pawn_loadout(pawn_idx).pawn_card = card
		
		Game.Domain.WEAPON:
			_remove_from_free(domain, card)
			if card_idx ==1:
				_replace_to_free(domain, _get_pawn_loadout(pawn_idx).weapon_card_1)
				_get_pawn_loadout(pawn_idx).weapon_card_1 = card
			else:
				_replace_to_free(domain, _get_pawn_loadout(pawn_idx).weapon_card_2)
				_get_pawn_loadout(pawn_idx).weapon_card_2 = card

		Game.Domain.TALISMAN:
			_replace_to_free(domain, _get_pawn_loadout(pawn_idx).talisman_card)
			_remove_from_free(domain, card)
			_get_pawn_loadout(pawn_idx).talisman_card = card


	_get_card_window(pawn_idx, domain, card_idx).texture = card.get_image()

	if (domain == Game.Domain.TALISMAN):
		return
	
	if not _is_pawn_weapon_valid(pawn_idx):
		_get_error_label(pawn_idx).text = "ERROR: Pawn And Weapon Types Must Match"
	else:
		_get_error_label(pawn_idx).text = ""
	
	var action_deck_type = _get_existing_action_type(pawn_idx)
	var single_card_type = _get_existing_single_type(pawn_idx)

	if action_deck_type != "" && single_card_type != "":
		if action_deck_type != single_card_type:
			_get_error_label(pawn_idx).text = "ERROR: Action Deck Must Match Pawn/Weapon Type"



func _is_pawn_weapon_valid(pawn_idx) -> bool:
	var card_types: Array
	var pawn := _get_pawn_loadout(pawn_idx).pawn_card
	if pawn != null:
		 card_types.append(pawn)

	var weapon_1 :=_get_pawn_loadout(pawn_idx).weapon_card_1
	if weapon_1 != null:
		card_types.append(weapon_1)

	var weapon_2 := _get_pawn_loadout(pawn_idx).weapon_card_2
	if weapon_2 != null:
		card_types.append(weapon_2)
	
	if card_types.empty():
		return true;

	var type = card_types[0].card_type
	for i in range (1, card_types.size()):
		if card_types[i].card_type != type:
			return false

	return true


func _get_existing_single_type(pawn_idx: int) -> String:
	if _get_pawn_loadout(pawn_idx).pawn_card != null:
		return _get_pawn_loadout(pawn_idx).pawn_card.card_type
	elif _get_pawn_loadout(pawn_idx).weapon_card_1 != null:
		return _get_pawn_loadout(pawn_idx).weapon_card_1.card_type
	elif _get_pawn_loadout(pawn_idx).weapon_card_2 != null:
		return _get_pawn_loadout(pawn_idx).weapon_card_2.card_type
	else:
		return ""
	

func _get_existing_action_type(pawn_idx: int) -> String:
	if not _get_pawn_loadout(pawn_idx).get_deck(Game.Domain.ACTION).empty():
		return _get_pawn_loadout(pawn_idx).get_deck(Game.Domain.ACTION)[0].card_type
	else:
		return ""


func _is_action_deck_valid(pawn_idx: int) -> bool:
	if _get_pawn_loadout(pawn_idx).get_deck(Game.Domain.ACTION).empty():
		return true
	else:
		var deck = _get_pawn_loadout(pawn_idx).get_deck(Game.Domain.ACTION)
		for i in range(1, deck.size()):
			if deck[i-1].card_type != deck[i].card_type:
				return false
		return true


func _set_deck_label(pawn_idx : int, domain : int, string : String):
	match(pawn_idx):
		Game.Pawn.PAWN1:
			if domain == Game.Domain.ACTION:
				$HSplit/VSplit/Pawn1/VBox/HBox3/VBox/AttackDeck/DeckName.text = string
			else:
				$HSplit/VSplit/Pawn1/VBox/HBox3/VBox/AbilityDeck/DeckName.text = string
		Game.Pawn.PAWN2:
			if domain == Game.Domain.ACTION:
				$HSplit/VSplit2/Pawn2/VBox/HBox3/VBox/AttackDeck/DeckName.text = string
			else:
				$HSplit/VSplit2/Pawn2/VBox/HBox3/VBox/AbilityDeck/DeckName.text = string
		Game.Pawn.PAWN3:
			if domain == Game.Domain.ACTION:
				$HSplit/VSplit/Pawn3/VBox/HBox3/VBox/AttackDeck/DeckName.text = string
			else:
				$HSplit/VSplit/Pawn3/VBox/HBox3/VBox/AbilityDeck/DeckName.text = string
		-1:
			$HSplit/VSplit2/SetInfo/HBox/DeckSettings/PowerDeck/DeckName.text = string
			

func _set_label_all(string : String):
	$HSplit/VSplit/Pawn1/VBox/HBox3/VBox/AttackDeck/DeckName.text = string
	$HSplit/VSplit/Pawn1/VBox/HBox3/VBox/AbilityDeck/DeckName.text = string
	$HSplit/VSplit2/Pawn2/VBox/HBox3/VBox/AttackDeck/DeckName.text = string
	$HSplit/VSplit2/Pawn2/VBox/HBox3/VBox/AbilityDeck/DeckName.text = string
	$HSplit/VSplit/Pawn3/VBox/HBox3/VBox/AttackDeck/DeckName.text = string
	$HSplit/VSplit/Pawn3/VBox/HBox3/VBox/AbilityDeck/DeckName.text = string
	$HSplit/VSplit2/SetInfo/HBox/DeckSettings/PowerDeck/DeckName.text = string


# These are passing an int that is indexed the same as
# Game.Pawn enum, ex. 0 = PAWN1, and are thus interchangeable 
func _on_SelectPawn_pressed(pawn_idx : int) -> void:
	_s_select.init(pawn_idx, Game.Domain.PAWN, _pawn_cards_free, 0)

	var ex_type = _pawn_set.pawn_loadouts[pawn_idx].weapon_card_1
	if ex_type == null:
		ex_type = _pawn_set.pawn_loadouts[pawn_idx].weapon_card_2

	if ex_type != null:
		_s_select.update_filtered_view(_s_select.get_type_int(ex_type.card_type), 0)

	_s_select.pop_up()


func _on_SelectWeapon_pressed(pawn_idx : int, weapon_idx) -> void:
	_s_select.init(pawn_idx, Game.Domain.WEAPON, _weapon_cards_free, weapon_idx)

	var ex_type = _pawn_set.pawn_loadouts[pawn_idx].pawn_card
	if ex_type != null:
		_s_select.update_filtered_view(_s_select.get_type_int(ex_type.card_type), 0)
		
	_s_select.pop_up()


func _on_SelectTalisman_pressed(pawn_idx: int) -> void:
	_s_select.init(pawn_idx, Game.Domain.TALISMAN, _talisman_cards_free, 0)
	_s_select.pop_up()


func _on_Build_pressed(pawn_idx : int, domain : int) -> void:
	_deck_builder.init(
		pawn_idx, 
		domain, 
		_get_all_by_domain(domain),
		_pawn_set.power_deck if domain == Game.Domain.POWER 
			else _get_pawn_loadout(pawn_idx).get_deck(domain))

	if domain == Game.Domain.ACTION && _get_existing_single_type(pawn_idx) != "":
		var type_int = _deck_builder.get_type_int(_get_existing_single_type(pawn_idx))
		_deck_builder.update_filtered_view(type_int, 0)
		
	$HSplit.hide()
	_deck_builder.show()
	#$Panel.add_child(_deck_builder)	# TODO maybe add at start and hide?
	

func _on_To_Menu_pressed():
#	$HSplit.queue_free()
#	$Panel.queue_free()
	Util.free_array(_pawn_cards_free)
	Util.free_array(_action_cards_free)
	Util.free_array(_weapon_cards_free)
	Util.free_array(_ability_cards_free)
	Util.free_array(_power_cards_free)
	_pawn_set.clean_up()
	_deck_builder.queue_free()
	get_tree().change_scene("res://ui/menu/menu.tscn")


func _on_deck_builder_close(domain: int, free : Array) -> void:
	Util.merge_non_duplicates(_get_all_by_domain(domain), free)  #Can directly merge? If ain't broke dont fix it :P
	#$Panel.remove_child(_deck_builder)
	_deck_builder.hide()
	$HSplit.show()


func _on_deck_builder_save(pawn_idx : int, domain : int, deck : Array, free : Array) -> void:
	if pawn_idx == -1:
		_pawn_set.power_deck = deck
	else:
		_get_pawn_loadout(pawn_idx).set_deck(domain, deck)
	#Util.erase_all(_get_all_by_domain(domain), deck)
	Util.merge_non_duplicates(_get_all_by_domain(domain), free)  #Can directly merge? If ain't broke dont fix it :P
	_set_deck_label(pawn_idx, domain, "Deck Saved")
	#$Panel.remove_child(_deck_builder)
	_deck_builder.hide()
	$HSplit.show()
	
	if domain == Game.Domain.ACTION:
		var action_deck_type = _get_existing_action_type(pawn_idx)
		var single_card_type = _get_existing_single_type(pawn_idx)
	
		if action_deck_type != "" && single_card_type != "":
			if action_deck_type != single_card_type:
				_get_error_label(pawn_idx).text = "ERROR: Action Deck Must Match Pawn/Weapon Type"
			else:
				_get_error_label(pawn_idx).text = ""

		if not _is_action_deck_valid(pawn_idx):
			_get_error_label(pawn_idx).text = "ERROR: Action Deck Must Contain Cards Of Same Type"


func _on_Save_pressed() -> void:
	var name = $HSplit/VSplit2/SetInfo/HBox/DeckSettings/HBox2/SetName.text
	if (name.empty() && set_name.empty()):
		_dialog.set_text("Pawn Set Must Have Name")
		_dialog.popup_centered()
		return

	_pawn_set.set_name = name
	
	_pawn_set.preferred_potions.clear()
	for option in _potion_options:
		if option.get_selected_id() != 0:
			_pawn_set.preferred_potions.append(option.get_item_text(option.get_selected_id()))

	if Player.set_exists(_pawn_set.set_number):
		# jank but needed due to the way confirmation dialogs return with signal
		_confirm_discon()
		_confirm.set_text("Save Will Overwrite Existing Pawn Set\n" +
			"Click OK To Confirm, Or Cancel And Select Save As New")
		_confirm.popup_centered()
		_confirm.connect("confirmed", self, "_on_saved_forked")
		return

	if not Player.add_pawn_set(_pawn_set):
		_dialog.set_text("Failed To Save, Too Many Saved Sets\n Limit: 5 (10 If Premium)\n Delete A Set Or Save Over Existing To Save")
		_dialog.popup_centered()
		return

	_net.send(NetPawnSet.new(_pawn_set))


func _on_saved_forked() -> void:
	_net.send(NetPawnSet.new(_pawn_set))


func _on_Load_pressed() -> void:
	_load.init(Player.get_pawn_sets())
	_load.popup_centered()


func _on_load_confirmed():

	var set_idx = _load.get_selected()
	_clear_cards_all()
	_pawn_set = Player._pawn_sets[set_idx]
	_set_label_all("Deck Saved")
	

	$HSplit/VSplit2/SetInfo/HBox/DeckSettings/HBox2/SetName.text = _pawn_set.set_name
	
	for domain in Game.Domain.values():
		var free_cards : Array = Player.get_owned_by_domain(domain)
		Util.erase_all(free_cards, _pawn_set.get_all_card_names(domain))
		_get_all_by_domain(domain).append_array(CardBase.instance_card_list(domain, free_cards))
	
	var set_validation := Game.validate_set(_pawn_set)
	
	if set_validation.get("valid") == false:
		var invalid = ""
		for inv in set_validation.get("invalid_cards"):
			invalid += str(inv +"\n")

		_dialog.set_text(str("Set Contains Cards No Longer Owned\nUn-Owned Cards\n", invalid))
		
	_add_card_context()

	for i in range(0, _pawn_set.preferred_potions.size()):
		for j in range(1, _potion_options[i].get_item_count()):
			if _potion_options[i].get_item_text(j) ==  _pawn_set.preferred_potions[i]:
				_potion_options[i].select(j)
	
	for pawn_idx in Game.Pawn.values():
		if _pawn_set.pawn_loadouts[pawn_idx].pawn_card != null:
			(_get_card_window(pawn_idx, Game.Domain.PAWN, 0).texture 
				= _pawn_set.pawn_loadouts[pawn_idx].pawn_card.get_image())
		else:
			_get_card_window(pawn_idx, Game.Domain.PAWN, 0).texture = null
				
		if _pawn_set.pawn_loadouts[pawn_idx].weapon_card_1 != null:
			(_get_card_window(pawn_idx, Game.Domain.WEAPON, 1).texture 
				= _pawn_set.pawn_loadouts[pawn_idx].weapon_card_1.get_image())
		else:
			_get_card_window(pawn_idx, Game.Domain.WEAPON, 1).texture = null

		if _pawn_set.pawn_loadouts[pawn_idx].weapon_card_2 != null:
			(_get_card_window(pawn_idx, Game.Domain.WEAPON, 2).texture 
				= _pawn_set.pawn_loadouts[pawn_idx].weapon_card_2.get_image())
		else:
			_get_card_window(pawn_idx, Game.Domain.WEAPON, 2).texture = null
		
		if _pawn_set.pawn_loadouts[pawn_idx].talisman_card != null:
			(_get_card_window(pawn_idx, Game.Domain.TALISMAN, 0).texture 
				= _pawn_set.pawn_loadouts[pawn_idx].talisman_card.get_image())
		else:
				_get_card_window(pawn_idx, Game.Domain.TALISMAN, 0).texture = null
	


func _on_save_response(valid: bool, reason: String) -> void:
	if valid:
		_dialog.set_text("Set Saved Successfully")
		_dialog.popup_centered()
	else:
		_dialog.set_text("Failed To Save\n" + "Reason: " + reason)
		_dialog.popup_centered()


func _on_New_pressed():
	# jank but needed due to the way confirmation dialogs return with signal
	_confirm_discon()
	_confirm.set_text("Create New Pawn Set?\nCurrent Pawn Set Will Be Lost If Not Saved")
	_confirm.popup_centered()
	_confirm.connect("confirmed", self, "_on_new_fork")


func _on_new_fork():
	_pawn_set = PawnSet.new()

	for pawn_idx in Game.Pawn.values():
		_get_card_window(pawn_idx, Game.Domain.PAWN, 0).texture = null
		_get_card_window(pawn_idx, Game.Domain.WEAPON, 1).texture = null
		_get_card_window(pawn_idx, Game.Domain.WEAPON, 2).texture = null
		_get_card_window(pawn_idx, Game.Domain.TALISMAN, 0).texture = null


func _on_SaveNew_pressed() -> void:
	var idx = Player.get_open_slot()

	if idx == -1:
		_dialog.set_text("Failed To Save, Too Many Saved Sets\n Limit: 5 (10 If Premium)\n Delete A Set Or Save Over Existing To Save")
		_dialog.popup_centered()
	else:
		_pawn_set.set_number = idx
		_on_Save_pressed()


func _on_Delete_pressed() -> void:
	# jank but needed due to the way confirmation dialogs return with signal
	_confirm_discon()
	_confirm.set_text("Current Pawn Set Will Be Deleted\n Set Name: " + _pawn_set.set_name)
	_confirm.popup_centered()
	_confirm.connect("confirmed", self, "_on_delete_fork")


func _on_delete_fork() -> void:
	Player.remove_pawn_set(_pawn_set.set_number)
	_net.send(NetSetDelete.new(_pawn_set.set_number))



func _on_Replace_pressed() -> void:
	_replace.init(Player.get_pawn_sets())
	_replace.popup_centered()


func _on_replace_confirmed() -> void:
	var name = $HSplit/VSplit2/SetInfo/HBox/DeckSettings/HBox2/SetName.text
	if (name.empty() && set_name.empty()):
		_dialog.set_text("Pawn Set Must Have Name")
		_dialog.popup_centered()
		return

	Player.remove_pawn_set(_replace.get_selected())
	_pawn_set.set_name = name
	_pawn_set.set_number = _replace.get_selected()
	
	_pawn_set.preferred_potions.clear()
	for option in _potion_options:
		if option.get_selected_id() != 0:
			_pawn_set.preferred_potions.append(option.get_item_text(option.get_selected_id()))

	_net.send(NetPawnSet.new(_pawn_set))


func _confirm_discon() -> void:
	var signals = _confirm.get_signal_list();
	for cur_signal in signals:
		var conns = _confirm.get_signal_connection_list(cur_signal.name);
		for cur_conn in conns:
			_confirm.disconnect(cur_conn.signal, cur_conn.target, cur_conn.method)
