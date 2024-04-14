extends Control

var previousLevel = Player_Data.previousLevel




func _on_restart_b_pressed():
	get_tree().change_scene_to_file("res://Level" + str(previousLevel) + ".tscn")


func _on_back_b_pressed():
	get_tree().change_scene_to_file("res://TitleMenu.tscn")
