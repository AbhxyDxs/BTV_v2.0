extends Area2D

var coins_to_collect : int = 3
var collected_coins : int = Player_Data.Coin


func _ready():
	pass


func _on_body_entered(body):
	if body.name == "VoidPlayer" || body.name == "Player":
		if collected_coins >= coins_to_collect:
			get_tree().change_scene("res://Level1.tscn")

