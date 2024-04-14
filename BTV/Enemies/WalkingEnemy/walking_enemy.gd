extends Enemey_Movement

func _ready():
	generate_random()
	#print(dir)


func _on_timer_timeout():
	generate_random()
	#print(dir)
	$Timer.start()


func _on_hit_box_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Player":
		eHealth -= 1
		hit_flash()
		#print(eHealth)
		
func hit_flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier",0.7)
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier",0)	
