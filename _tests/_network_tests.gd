extends Panel


func _ready():
#	Network.connect("msg_received", self, "showmsg")
#	Network.connect("disconnected", self, "discon")
#
#	var err = Network.init_wss_conn("123")
#	print(err)
#	err = Network.send("HI")
#	print(err)
	pass

func showmsg(msg : String):
	print(msg)

func discon() :
	print ("wss disconnected")
