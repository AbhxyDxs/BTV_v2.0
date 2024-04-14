extends TextureButton  # Change this based on the type of button node you are using

func _on_touch_screen_button_pressed():
	Input.action_press("Attack")

