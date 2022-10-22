extends Node

const https_auth : String = "https://127.0.0.1:8443/auth"
const https_reg : String = "https://127.0.0.1:8443/register"
const wss_url : String = "wss://127.0.0.1:443"
onready var wss_client := WebSocketClient.new()
# TODO add http request here and grab globally
var auth_token : String


func _ready() -> void:
	print(wss_client)
	wss_client.connect("connection_closed", self, "_closed")
	wss_client.connect("connection_error", self, "_closed")
	wss_client.connect("connection_established", self, "_connected")
	wss_client.connect("connection_established", self, "_connected")
	wss_client.set_verify_ssl_enabled(true)
	
	# testing
	var header =  ["Content-Type: application/json" , "token:123"]
	wss_client.connect_to_url(wss_url,[], false, header)
	
	


func _PhysicsProcess(delta):
	if wss_client.get_connection_status() > 0:
		wss_client.poll()


# TODO : Switch prints to logs
func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	emit_signal("disconnected")


func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	wss_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	

func _on_data():
	print("Got data from server: ", wss_client.get_peer(1).get_packet().get_string_from_utf8())
	emit_signal("msg_received", wss_client.get_peer(1).get_packet().get_string_from_utf8())


func send (msg : String) -> bool:
	print("send")
	var err = wss_client.get_peer(1).put_packet(msg.to_utf8())
	return false if err > 0 else true


func init_wss_conn(token : String) -> bool:
	var auth =  {"token" : token}
	var header =  ["Content-Type: application/json" , token]
	wss_client.connect_to_url(wss_url,[], false, header)
	#return false if err > 0 else true
	return true



signal msg_received(msg)
signal disconnected()


######################################################
## CLASSES AND CONSTANTS FOR NETWORK SERIALIZATIONS ##
######################################################

enum _Out_Type{
	SAVE_SET,
	DELETE_SET,
	QUEUE,
	DE_QUEUE
}

enum _In_Type{
	TURN_UPDATE,
	INSIGHT,
	DEAD,
	GAME_OVER,
	EFFECT,
	STAT_UPDATE,
	TURN_RESPONSE
}

const n_msg_out = {
	_Out_Type.SAVE_SET 	 : "SAVE_SET",
	_Out_Type.DELETE_SET : "DELETE_SET",
	_Out_Type.QUEUE 	 : "QUEUE",
	_Out_Type.DE_QUEUE 	 : "DE_QUEUE"
}

const n_msg_in = {
	"TURN_UPDATE"   : _In_Type.TURN_UPDATE,
	"INSIGHT" 	    : _In_Type.INSIGHT,
	"DEAD"		    : _In_Type.DEAD,
	"GAME_OVER"	    : _In_Type.GAME_OVER,
	"EFFECT"	    : _In_Type.EFFECT,
	"STAT_UPDATE"   : _In_Type.STAT_UPDATE,
	"TURN_RESPONSE" : _In_Type.TURN_RESPONSE
}

const n_pawn_in = {
	"PAWN1" : Game.Pawn.PAWN1, 
	"PAWN2" : Game.Pawn.PAWN2, 
	"PAWN3" : Game.Pawn.PAWN3
	}

const n_pawn_out = {
	Game.Pawn.PAWN1 : "PAWN1",
	Game.Pawn.PAWN2 : "PAWN2",
	Game.Pawn.PAWN3 : "PAWN3"
}


