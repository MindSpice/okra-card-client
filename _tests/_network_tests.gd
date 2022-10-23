extends Panel

var msgs : Array


func _ready():
	Network.connect("msg_received", self, "showmsg")
	Network.connect("disconnected", self, "discon")

	var err = Network.init_wss_conn("123")

	
func send():
	var err = Network.send("HI")
	print(err)


func showmsg(msg : Dictionary):
	print(msg)
	match (Network.msg_in_type(msg.get("msg_type"))):
		
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
			
			
	
		
			

		
			
func discon() :
	print ("wss disconnected")
