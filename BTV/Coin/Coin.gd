extends Area2D

func _on_body_entered(body):
	if body.name == "VoidPlayer" || body.name == "Player":
		Player_Data.Coin += 1
		#Player_Data.Health -= 1 #Used for testing Health
		#print("Your Health is ",Player_Data.Health)
		#print(Player_Data.Coin)
		#queue_free() trying to add a bounce animation for coin, when collected
		$AnimationPlayer.play("CoinBounce")
		#Add this to each level for completion check
		#if Player_Data.Coin == 10:
		#	await get_tree().create_timer(1).timeout
		#	get_tree().change_scene_to_file("res://Level1.tscn") #Level Completed Screen
		#	Player_Data.Coin = 0
		


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
