extends Node

const https_auth : String = "https://127.0.0.1:8443/auth"
const https_reg : String = "https://127.0.0.1:8443/register"
const wss_url : String = "wss://127.0.0.1:4448"
var wss_client := WebSocketClient.new()
# TODO add http request here and grab globally
var auth_token : String


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
	wss_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)


func _on_data():
	var data := JSON.parse(wss_client.get_peer(1).get_packet().get_string_from_utf8())

	
	emit_signal("msg_received", data.result)


func send (msg : String) -> bool:
	print("send")
	var err = wss_client.get_peer(1).put_packet(JSON.print(msg).to_utf8())
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


######################################################
## CLASSES AND CONSTANTS FOR NETWORK SERIALIZATIONS ##
######################################################

enum MsgOut {
	SAVE_SET,
	DELETE_SET,
	QUEUE,
	DE_QUEUE
}

enum MsgIn {
	TURN_UPDATE,
	INSIGHT,
	DEAD,
	GAME_OVER,
	EFFECT,
	STAT_UPDATE,
	TURN_RESPONSE
	REJOIN
}

enum InsightType {
	CARD,
	EFFECT,
	STAT
}

const n_msg_out = {
	MsgOut.SAVE_SET 	 : "SAVE_SET",
	MsgOut.DELETE_SET : "DELETE_SET",
	MsgOut.QUEUE 	 : "QUEUE",
	MsgOut.DE_QUEUE 	 : "DE_QUEUE"
}

const n_msg_in = {
	"TURN_UPDATE"   : MsgIn.TURN_UPDATE,
	"INSIGHT" 	    : MsgIn.INSIGHT,
	"DEAD"		    : MsgIn.DEAD,
	"GAME_OVER"	    : MsgIn.GAME_OVER,
	"EFFECT"	    : MsgIn.EFFECT,
	"STAT_UPDATE"   : MsgIn.STAT_UPDATE,
	"TURN_RESPONSE" : MsgIn.TURN_RESPONSE,
	"REJOIN" 		: MsgIn.REJOIN
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

func msg_in_type(msg_type : String) -> int:
	return n_msg_in.get(msg_type)
	
func conv_pawn_arr(arr : Array) -> Array:
	var rtn_arr : Array
	for pawn in arr:
		rtn_arr.append(_pawn_in.get(pawn))
	return rtn_arr

func conv_pawn_in(pawn : String) -> int:
	return _pawn_in.get(pawn)
	
func conv_pawn_out(pawn : int) -> String:
	return  _pawn_out.get(pawn)
	

	
const insight_type = {
	"CARD" 		: InsightType.CARD,
	"EFFECT"  	: InsightType.EFFECT,
	"STAT" 		: InsightType.STAT
}



