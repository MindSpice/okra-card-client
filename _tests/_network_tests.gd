extends Panel

var msgs : Array


func _ready():
	var err
	err = Network.connect("msg_received", self, "showmsg")
	Network.connect("disconnected", self, "discon")

	err = Network.init_wss_conn("123")
	print(err)

	
func _init():
	pass

func send():
	var nga := NetGameAction.new(
		Game.PlayerAction.WEAPON_CARD_1,
		Game.Pawn.PAWN1, 
		Game.Pawn.PAWN3, 
		"")
	# var nlq := NetLobbyQueue.new(
	# 	true,
	# 	1,
	# 	[]
	# )
	#Network.send(nlq)
	Network.send(nga)

	for domain in Game.Domain.values():
		print(Player.get_owned_by_domain(domain))



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
			
