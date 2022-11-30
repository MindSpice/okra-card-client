extends Panel

func set_hidden(hidden):
	for child in $HBox.get_children():
		child.set_hidden(hidden)
		if hidden:
			hide()
		else:
			show()
