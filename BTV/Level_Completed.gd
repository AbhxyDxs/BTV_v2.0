extends Control

#var previousLevel : int = 0
var previousLevel = Player_Data.previousLevel
func _ready():
	# Assume that the level cleared screen is visible at the start
	pass

func show_level_cleared(previous_level: int):
	# Store the previous level
	#previousLevel = previous_level

	# Show the level cleared screen
	#show()
	pass
	


func _on_next_b_pressed():
	# Hide the level cleared screen
	hide()

	# Load the next level
	var nextLevel = previousLevel + 1
	if nextLevel <= 5:  # Assuming you have a total of 5 levels
		# Load the next level scene
		get_tree().change_scene_to_file("res://Level" + str(nextLevel) + ".tscn")
	else:
		# You've completed all levels, handle accordingly
		print("Game completed!")

	# Reset previous level
	Player_Data.previousLevel += 1 
	Player_Data.Health = 4


func _on_restart_b_pressed():
	get_tree().change_scene_to_file("res://Level" + str(previousLevel) + ".tscn")


func _on_back_b_pressed():
	get_tree().change_scene_to_file("res://TitleMenu.tscn")
