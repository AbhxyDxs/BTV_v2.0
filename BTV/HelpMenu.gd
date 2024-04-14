extends Control

func _on_how_to_play_b_pressed():
	get_tree().change_scene_to_file("res://HowToPlayMenu.tscn")


func _on_control_help_b_pressed():
	get_tree().change_scene_to_file("res://ControlsMenu.tscn")


func _on_back_b_pressed():
	get_tree().change_scene_to_file("res://TitleMenu.tscn")
