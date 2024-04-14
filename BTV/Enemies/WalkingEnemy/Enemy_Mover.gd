extends CharacterBody2D
class_name Enemey_Movement

var current_states
enum  Enemy_States {
	WALK_RIGHT,
	WALK_LEFT,
	WALK_UP,
	WALK_DOWN,
	DEAD
}

@onready var dead_anim = preload("res://Effects/dead_fx.tscn")
#@onready var dead_anim = preload("res://Effects/enemy_death_effect.tscn")
@onready var hp_loot = preload("res://HealthPortion/hp.tscn")
@export var speed = 10
@export var eHealth = 3
var dir

func _physics_process(delta):
	if eHealth <= 0:
		current_states = Enemy_States.DEAD
	
	match current_states:
		Enemy_States.WALK_RIGHT:
			walk_right()
		Enemy_States.WALK_LEFT:
			walk_left()
		Enemy_States.WALK_UP:
			walk_up()
		Enemy_States.WALK_DOWN:
			walk_down()
		Enemy_States.DEAD:
			dead()
			
	move_and_slide()
	
func generate_random():
	dir = randi() % 4
	random_direction()
	
func random_direction():
	match dir:
		0:
			current_states = Enemy_States.WALK_RIGHT
		1:
			current_states = Enemy_States.WALK_LEFT
		2:
			current_states = Enemy_States.WALK_UP
		3:
			current_states = Enemy_States.WALK_DOWN

func walk_right():
	velocity = Vector2.RIGHT * speed
	$EnemyAnim.play("Walk_Right")
	
func walk_left():
	velocity = Vector2.LEFT * speed
	$EnemyAnim.play("Walk_Left")
	
func walk_up():
	velocity = Vector2.UP * speed
	$EnemyAnim.play("Walk_Up")
	
func walk_down():
	velocity = Vector2.DOWN * speed
	$EnemyAnim.play("Walk_Down")
	
func dead():
	dead_animation()
	queue_free()
	
func dead_animation():
	var dead = dead_anim.instantiate()
	dead.global_position = global_position
	get_tree().get_root().add_child(dead)
	loot_gem()
	
func loot_gem():
	var gem = hp_loot.instantiate()
	gem.global_position = global_position
	get_tree().get_root().add_child(gem)
