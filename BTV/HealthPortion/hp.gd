extends Node2D


func _on_health_portion_body_entered(body):
	if body.name == "Player":
		if Player_Data.Health < 4:
			Player_Data.Health += 1
			queue_free()
