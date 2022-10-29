extends Panel

var msgs : Array


func _ready():
	Network.connect("msg_received", self, "showmsg")
	Network.connect("disconnected", self, "discon")

	var err = Network.init_wss_conn("123")

	
func _init():
	pass

func send():
	var nga := NetGameAction.new(
		Game.PlayerAction.ATTACK_HEAVY, 
		Game.Pawn.PAWN1, 
		Game.Pawn.PAWN3, 
		"")
	var nlq := NetLobbyQueue.new(
		true,
		"set1"
	)
		
	#Network.send(nlq)
	Network.send(nga)


func re_auth(username: String, password : String) -> int:
	return - 1
	

func showmsg(msg : Dictionary):
	print(msg)
	match (Network.conv_msg_in(msg.get("msg_type"))):
		
		Network.MsgIn.DEAD:
			msgs.append(NetDead.new(msg))
			
		Network.MsgIn.EFFECT:
			msgs.append(NetEffect.new(msg))
			
		Network.MsgIn.GAME_OVER:
			msgs.append(NetGameOver.new(msg))
			
		Network.MsgIn.INSIGHT:
			pass
			# TODO add and test later, waiting on server side
			
		Network.MsgIn.STAT_UPDATE:
			msgs.append(NetStat.new(msg))
			
		Network.MsgIn.TURN_RESPONSE:
			msgs.append(NetTurnResponse.new(msg))
			
		Network.MsgIn.TURN_UPDATE:
			msgs.append(NetTurnUpdate.new(msg))

		Network.MsgIn.CARD_UPDATE:
			msgs.append(NetCardUpdate.new(msg))
			
