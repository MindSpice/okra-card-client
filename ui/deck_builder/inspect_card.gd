extends Control


func set_card(card : Card):
	$Window/CardView.texture = card.get_image()

func pop_up():
	$Window.popup_centered()
