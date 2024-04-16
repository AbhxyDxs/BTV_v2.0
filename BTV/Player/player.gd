extends CharacterBody2D

@export var MAX_SPEED = 100
@export var ACCELERATION = 500
@export var FRICTION = 500

@onready var axis = Vector2.ZERO
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

@onready var joystick = get_parent().get_node_or_null("CanvasLayer").get_node("Joystick")

var roll_vector = Vector2.DOWN

var state = MOVE
enum{
	MOVE,
	ROLL,
	ATTACK,
	DEAD
}

func _ready():
	print(joystick)
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
		DEAD:
			dead()
			
	if Player_Data.Coin == 10:
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://Level_Completed.tscn") #Level Completed Screen
			Player_Data.Coin = 0

func move_state(delta):
	#For Keyboard
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	axis = axis.normalized()


	#For Touchscreen
#	axis = joystick.posVector


	if axis == Vector2.ZERO:
		animationState.travel("Idle")
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else:
		roll_vector = axis 
		animationState.travel("Run")
		animationTree.set("parameters/Idle/blend_position",axis)
		animationTree.set("parameters/Run/blend_position",axis)
		animationTree.set("parameters/Attack/blend_position",axis)
		animationTree.set("parameters/Roll/blend_position",axis)
		
		velocity += (axis * ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)
		
	move_and_slide()
	
	if Input.is_action_pressed("Attack"):
		state = ATTACK
	
	if Input.is_action_pressed("Roll"):
		state = ROLL
		
	if Player_Data.Health <= 0:
		state = DEAD

func attack_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func roll_state(_delta):
	velocity = roll_vector * MAX_SPEED * 1.2
	animationState.travel("Roll")
	move_and_slide()

func AttackAnimationFinished():
	state = MOVE

func RollAnimationFinished():
	state = MOVE


func _on_sword_hitbox_area_entered(area):
	if area.name == "Grass_Area2D":
		area.get_parent().grass_kill = true
		
func dead():
	animationState.travel("Dead")
	await get_tree().create_timer(1).timeout
	Player_Data.Health = 4
	Player_Data.Coin = 0
#	get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://Level_Failed.tscn")
	
func hit_flash():
	$Sprite2D.material.set_shader_parameter("flash_modifier",0.7)
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.material.set_shader_parameter("flash_modifier",0)	
	
func on_states_reset():
	state = MOVE

func _on_hit_box_area_entered(area):
	if area.name != "Detection_Area":
		#area.get_parent().retreat()
		hit_flash()
		Player_Data.Health -= 1
