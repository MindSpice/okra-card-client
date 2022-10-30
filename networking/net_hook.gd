extends Reference

class_name NetHook

var game_over_time : int = 0

func _init():
	var e =Network.connect("msg_received", self, "process_msg")
	Network.connect("disconnected", self, "disconnection")

	#var err = Network.init_wss_conn("123")


func send(nga : NetGameAction):
	var err = Network.send(nga)
	print(err)
	
func _process():
	if game_over_time > 0:
		if (game_over_time + 20) > OS.get_unix_time():
			emit_signal("end_game")

func process_msg(msg : Dictionary):
	
	match (Network.conv_msg_in(msg.get("msg_type"))):
		Network.MsgIn.DEAD:
			emit_signal("dead_update", NetDead.new(msg))
			
		Network.MsgIn.EFFECT:
			emit_signal("effect_update", NetEffect.new(msg))
			
		Network.MsgIn.GAME_OVER:
			game_over_time = OS.get_unix_time()
			emit_signal("game_over", NetGameOver.new(msg))
			
		Network.MsgIn.INSIGHT:
			pass
			emit_signal("insight_update", null)
			# TODO add and test later, waiting on server side
			
		Network.MsgIn.STAT_UPDATE:
			emit_signal("stat_update", NetStat.new(msg))
			
		Network.MsgIn.TURN_RESPONSE:
			emit_signal("turn_response", NetTurnResponse.new(msg))
			
		Network.MsgIn.TURN_UPDATE:
			emit_signal("turn_update", NetTurnUpdate.new(msg))	

		Network.MsgIn.CARD_UPDATE:
			emit_signal("card_update", NetCardUpdate.new(msg))	


func disconnection():
	emit_signal("disconn")
	print("Disconnection")
	#TODO add reconnection logic and fire signal if sucessfull
	#try token,
	# reauth if not
	#try again
	emit_signal("reconn")
	#else time >
	#emit_signal("close_game")
	
	
signal dead_update(net_dead)
signal effect_update(net_effect)
signal game_over(net_game_over)
signal insight_update(net_insight)
signal stat_update(net_stat_update)
signal turn_response(net_turn_response)
signal turn_update(net_turn_update)
signal card_update(net_card_update)

signal disconn()
signal reconn()
signal end_game()
