extends Control

func _on_play_b_pressed():
	get_tree().change_scene_to_file("res://Level0.tscn")


func _on_quit_b_pressed():
	get_tree().quit()


func _on_help_b_pressed():
	get_tree().change_scene_to_file("res://HelpMenu.tscn")
