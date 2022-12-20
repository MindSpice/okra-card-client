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
	process_msg(data.result)


func send (msg : Object) -> bool:
	var err = wss_client.get_peer(1).put_packet(to_json(msg.data).to_utf8())
	return false if err > 0 else true


func init_wss_conn(token : String) -> bool:
	var auth =  "token:" + token
	var header =  ["Content-Type: application/json" , auth]
	wss_client.connect_to_url(wss_url,[], false, header)
	#return false if err > 0 else true
	return true

func process_msg(msg : Dictionary):
	print(msg)

	
	match (Network.conv_msg_in(msg.get("msg_type"))):
		MsgIn.DEAD:
			emit_signal("dead_update", NetDead.new(msg))
			
		MsgIn.EFFECT:
			emit_signal("effect_update", NetEffect.new(msg))
			
		MsgIn.GAME_OVER:
			emit_signal("game_over", NetGameOver.new(msg))
			
		MsgIn.INSIGHT:
			pass
			emit_signal("insight_update", null)
			# TODO add and test later, waiting on server side
			
		MsgIn.STAT_UPDATE:
			emit_signal("stat_update", NetStat.new(msg))
			
		MsgIn.TURN_RESPONSE:
			emit_signal("turn_response", NetTurnResponse.new(msg))
			
		MsgIn.TURN_UPDATE:
			emit_signal("turn_update", NetTurnUpdate.new(msg))	

		MsgIn.CARD_UPDATE:
			emit_signal("card_update", NetCardUpdate.new(msg))	

		MsgIn.PAWN_SET_UPDATE:
			Player.set_pawn_sets(msg.get("pawn_sets"))

		MsgIn.QUEUE_RESPONSE:
			emit_signal("queue_response", NetQueueResponse.new(msg))
		
		MsgIn.SET_RESPONSE:
			print("here")
			emit_signal("set_response", msg.get("is_valid"), msg.get("reason"))


signal disconnected()
signal connection()	
signal dead_update(net_dead)
signal effect_update(net_effect)
signal game_over(net_game_over)
signal insight_update(net_insight)
signal stat_update(net_stat_update)
signal turn_response(net_turn_response)
signal turn_update(net_turn_update)
signal card_update(net_card_update)
signal queue_response(net_queue_response)
signal set_response(is_valid, reason)



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
	TURN_RESPONSE,
	REJOIN,
	CARD_UPDATE,
	PAWN_SET_UPDATE,
	QUEUE_RESPONSE,
	SET_RESPONSE,
	OWNED_CARDS,
}

enum MsgOut {
	JOIN_QUEUE,
	LEAVE_QUEUE,
	SAVE_PAWN_SET,
	POTION_PURCHASE,
	FETCH_CARDS,
	FETCH_PAWN_SETS,
	DELETE_PAWN_SET,
}

enum InsightType {
	CARD,
	EFFECT,
	STAT
}

const _n_msg_in = {
	"TURN_UPDATE"   	: MsgIn.TURN_UPDATE,
	"INSIGHT" 	    	: MsgIn.INSIGHT,
	"DEAD"		    	: MsgIn.DEAD,
	"GAME_OVER"	    	: MsgIn.GAME_OVER,
	"EFFECT"	    	: MsgIn.EFFECT,
	"STAT_UPDATE"   	: MsgIn.STAT_UPDATE,
	"TURN_RESPONSE" 	: MsgIn.TURN_RESPONSE,
	"REJOIN" 			: MsgIn.REJOIN,
	"CARD_UPDATE"		: MsgIn.CARD_UPDATE,
	"PAWN_SET_UPDATE"	: MsgIn.PAWN_SET_UPDATE,
	"QUEUE_RESPONSE"	: MsgIn.QUEUE_RESPONSE,
	"SET_RESPONSE"		: MsgIn.SET_RESPONSE,
	"OWNED_CARDS"		: MsgIn.OWNED_CARDS
}

const _n_msg_out = {
	MsgOut.JOIN_QUEUE		: "JOIN_QUEUE",
	MsgOut.LEAVE_QUEUE		: "LEAVE_QUEUE",
	MsgOut.SAVE_PAWN_SET	: "SAVE_PAWN_SET",
	MsgOut.POTION_PURCHASE	: "POTION_PURCHASE",
	MsgOut.FETCH_PAWN_SETS	: "FETCH_PAWN_SETS",
	MsgOut.FETCH_CARDS		: "FETCH_CARDS",
	MsgOut.DELETE_PAWN_SET	: "DELETE_PAWN_SET"
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

const _player_action_out = {
	Game.PlayerAction.WEAPON_CARD_1	  : "WEAPON_CARD_1",
	Game.PlayerAction.WEAPON_CARD_2	  : "WEAPON_CARD_2",
	Game.PlayerAction.ACTION_CARD_1   : "ACTION_CARD_1", 
	Game.PlayerAction.ACTION_CARD_2   : "ACTION_CARD_2", 
	Game.PlayerAction.ABILITY_CARD_1  : "ABILITY_CARD_1",
	Game.PlayerAction.ABILITY_CARD_2  : "ABILITY_CARD_2",
	Game.PlayerAction.POTION 		  : "POTION", 
	Game.PlayerAction.END_TURN 		  : "END_TURN", 
	Game.PlayerAction.SKIP_PAWN 	  : "SKIP_PAWN"
}

const _player_action_in = {
	"WEAPON_CARD_1" 		: Game.PlayerAction.WEAPON_CARD_1,
	"WEAPON_CARD_2" 		: Game.PlayerAction.WEAPON_CARD_2,
	"ACTION_CARD_1" 			: Game.PlayerAction.ACTION_CARD_1,
	"ACTION_CARD_2" 			: Game.PlayerAction.ACTION_CARD_2 ,
	"ABILITY_CARD_1" 			: Game.PlayerAction.ABILITY_CARD_1,
	"ABILITY_CARD_2" 			: Game.PlayerAction.ABILITY_CARD_2,
	"POTION" 					: Game.PlayerAction.POTION ,
	"END_TURN"					: Game.PlayerAction.END_TURN,
	"SKIP_PAWN"					: Game.PlayerAction.SKIP_PAWN
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
	"PAWN_CARD"			: Game.CardSlot.PAWN_CARD,
	"WEAPON_CARD_1"  	    : Game.CardSlot.WEAPON_CARD_1,
	"WEAPON_CARD_2"  	    : Game.CardSlot.WEAPON_CARD_2,
	"ACTION_CARD_1"		: Game.CardSlot.ACTION_CARD_1,
	"ACTION_CARD_2"		: Game.CardSlot.ACTION_CARD_2,
	"ABILITY_CARD_1"	: Game.CardSlot.ABILITY_CARD_1,
	"ABILITY_CARD_2"	: Game.CardSlot.ABILITY_CARD_2,
	"POWER_CARD"		: Game.CardSlot.POWER_CARD
}

const _action_flags_in = {
	"REFLECTED" 	: Game.ActionFlags.REFLECTED,
	"RESISTED" 		: Game.ActionFlags.RESISTED,
	"DOUBLED" 		: Game.ActionFlags.DOUBLED,
	"DAMAGED"		: Game.ActionFlags.DAMAGED,
	"EFFECTED"		: Game.ActionFlags.EFFECTED,
	"SUCCESS"		: Game.ActionFlags.SUCCESS,
	"UNSUCCESSFUL"	: Game.ActionFlags.UNSUCCESSFUL,
	"CONFUSED"		: Game.ActionFlags.CONFUSED
}



# const _action_flags_out = {
# 	Game.ActionFlags.REFLECTED 		: "REFLECTED",
# 	Game.ActionFlags.RESISTED 		: "RESISTED",
# 	Game.ActionFlags.DOUBLED 		: "DOUBLED",
# 	Game.ActionFlags.DAMAGED		: "DAMAGED",
# 	Game.ActionFlags.EFFECTED		: "EFFECTED",
# 	Game.ActionFlags.SUCCESS		: "SUCCESS",
# 	Game.ActionFlags.UNSUCCESSFUL	: "UNSUCCESSFUL",
# 	CGame.ActionFlags.CONFUSED		: "CONFUSED"
# }




func conv_msg_in(msg_type : String) -> int:
	return _n_msg_in.get(msg_type)


func conv_msg_out(msg_type: int) -> String:
	return _n_msg_out.get(msg_type)


func conv_pawn_arr(arr : Array) -> Array:
	var rtn_arr : Array
	for pawn in arr:
		rtn_arr.append(_pawn_in.get(pawn))
	return rtn_arr


func conv_pawn_in(pawn : String) -> int:
	return _pawn_in.get(pawn)


func conv_pawn_out(pawn : int) -> String:
	return  _pawn_out.get(pawn)	


func conv_player_action_out(player_action : int) -> String:
	return _player_action_out.get(player_action)


func conv_player_action_in(player_action : String) -> int:
	return _player_action_in.get(player_action)


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


func conv_effect_arr(effects : Array) -> Dictionary:
	var rtn_dict : Dictionary
	for effect in effects:
		var e = Game._effect_type.get(effect)
		rtn_dict[e[0]] = e[1]
	return rtn_dict

func conv_turn_reponse(reponse : Array) -> Dictionary:
	var rtn_dict : Dictionary
	for item in reponse:
		rtn_dict[conv_pawn_in(item.get("pawn"))] = item.get("action_flags") if item.get("pawn") != null else {}
	return rtn_dict



	
	
