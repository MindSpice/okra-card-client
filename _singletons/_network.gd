extends Node

const https_auth : String = "https://127.0.0.1:8443/auth"
const https_reg : String = "https://127.0.0.1:8443/register"
const wss_url : String = "wss://127.0.0.1:4449"
var wss_client := WebSocketClient.new()
# TODO add http request here and grab globally
var auth_token : String
var username : String


#TODO add http code here

###############
## WEBSOCKET ##
###############

func _ready() -> void:
	wss_client.connect("connection_closed", self, "_closed")
	wss_client.connect("connection_error", self, "_closed")
	wss_client.connect("connection_established", self, "_connected")
	wss_client.connect("data_received", self, "_on_data")
	wss_client.set_verify_ssl_enabled(true)


func _physics_process(delta):
		wss_client.poll()


# TODO : Switch prints to logs
func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	emit_signal("disconnected")


func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	emit_signal("connection")
	wss_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	

func _on_data():
	var data := JSON.parse(wss_client.get_peer(1).get_packet().get_string_from_utf8())
	emit_signal("msg_received", data.result)


func send (msg : Object) -> bool:
	var err = wss_client.get_peer(1).put_packet(to_json(msg.data).to_utf8())
	return false if err > 0 else true


func init_wss_conn(token : String) -> bool:
	var auth =  "token:" + token
	var header =  ["Content-Type: application/json" , auth]
	print(auth)
	wss_client.connect_to_url(wss_url,[], false, header)
	#return false if err > 0 else true
	return true
#
#
#
signal msg_received(msg)
signal disconnected()
signal connection()


######################################################
## CLASSES AND CONSTANTS FOR NETWORK SERIALIZATIONS ##
######################################################


enum MsgIn {
	TURN_UPDATE,
	INSIGHT,
	DEAD,
	GAME_OVER,
	EFFECT,
	STAT_UPDATE,
	TURN_RESPONSE
	REJOIN,
	CARD_UPDATE
}

enum InsightType {
	CARD,
	EFFECT,
	STAT
}

const _n_msg_in = {
	"TURN_UPDATE"   : MsgIn.TURN_UPDATE,
	"INSIGHT" 	    : MsgIn.INSIGHT,
	"DEAD"		    : MsgIn.DEAD,
	"GAME_OVER"	    : MsgIn.GAME_OVER,
	"EFFECT"	    : MsgIn.EFFECT,
	"STAT_UPDATE"   : MsgIn.STAT_UPDATE,
	"TURN_RESPONSE" : MsgIn.TURN_RESPONSE,
	"REJOIN" 		: MsgIn.REJOIN,
	"CARD_UPDATE"	: MsgIn.CARD_UPDATE
}

const _pawn_in = {
	"PAWN1" : Game.Pawn.PAWN1, 
	"PAWN2" : Game.Pawn.PAWN2, 
	"PAWN3" : Game.Pawn.PAWN3
	}

const _pawn_out = {
	Game.Pawn.PAWN1 : "PAWN1",
	Game.Pawn.PAWN2 : "PAWN2",
	Game.Pawn.PAWN3 : "PAWN3"
}

const _player_action = {
	Game.PlayerAction.ATTACK_LIGHT  : "ATTACK_LIGHT", 
	Game.PlayerAction.ATTACK_HEAVY  : "ATTACK_HEAVY", 
	Game.PlayerAction.ACTION_CARD_1 : "ACTION_CARD_1", 
	Game.PlayerAction.ACTION_CARD_2 : "ACTION_CARD_2", 
	Game.PlayerAction.ABILITY_CARD  : "ABILITY_CARD", 
	Game.PlayerAction.POTION 		: "POTION", 
	Game.PlayerAction.END_TURN 		: "END_TURN", 
	Game.PlayerAction.SKIP_PAWN 	: "SKIP_PAWN"
}

const _insight_type = {
	"CARD" 		: InsightType.CARD,
	"EFFECT"  	: InsightType.EFFECT,
	"STAT" 		: InsightType.STAT
}

const _stat_type = {
		"HP"		: Game.StatType.HP,
		"DP" 		: Game.StatType.DP,
		"SP"		: Game.StatType.SP,
		"MP" 		: Game.StatType.MP,
		"WILLPOWER"	: Game.StatType.WILLPOWER,
		"LUCK" 		: Game.StatType.LUCK		
	}

const _card_slot = {
	"pawn_card"		: Game.CardSlot.PAWN_CARD,
	"weapon_card"	: Game.CardSlot.WEAPON_CARD,
	"action_card_1"	: Game.CardSlot.ACTION_CARD_1,
	"action_card_2"	: Game.CardSlot.ACTION_CARD_2,
	"ability_card"	: Game.CardSlot.ABILITY_CARD,
	"power_card"	: Game.CardSlot.POWER_CARD
}


func conv_msg_in(msg_type : String) -> int:
	return _n_msg_in.get(msg_type)


func conv_pawn_arr(arr : Array) -> Array:
	var rtn_arr : Array
	for pawn in arr:
		rtn_arr.append(_pawn_in.get(pawn))
	return rtn_arr


func conv_pawn_in(pawn : String) -> int:
	return _pawn_in.get(pawn)


func conv_pawn_out(pawn : int) -> String:
	return  _pawn_out.get(pawn)	


func conv_player_action(player_action : int) -> String:
	return _player_action.get(player_action)


func conv_stat_dict(stat_dict : Dictionary) -> Dictionary:
	var rtn_dict : Dictionary
	for stat in stat_dict:
		rtn_dict[_stat_type.get(stat)] = stat_dict.get(stat)
		
	return rtn_dict


func conv_card_hand(card_hand : Dictionary) -> Dictionary:
	var rtn_dict : Dictionary
	for card in card_hand:
		rtn_dict[_card_slot.get(card)] = card_hand.get(card)

	return rtn_dict
	
