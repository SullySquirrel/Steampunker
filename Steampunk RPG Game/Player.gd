extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = $"."

enum player_state {
	IDLE,
	WALKING,
	RUNNING,
	ATTACK
}
@onready var current_state = player_state.IDLE

@export var SPEED = 50.0
@export var ACCELERATION = 100.0
@export var FRICTION = 200.0

func _physics_process(delta):
	var input_axis = Input.get_vector("left", "right", "up", "down")
	get_input()
	handle_player_states(player_state, input_axis, delta)
	print(current_state)
	move_and_slide()

func get_input():
	if Input.is_action_just_pressed("left"):
		current_state = player_state.WALKING
	elif Input.is_action_just_pressed("right"):
		current_state = player_state.WALKING
	elif Input.is_action_just_pressed("up"):
		current_state = player_state.WALKING
	elif Input.is_action_just_pressed("down"):
		current_state = player_state.WALKING

func handle_player_states(player_state, input_axis, delta):
	# Update player based on current state
	match current_state:
		player_state.IDLE:
			pass
		player_state.WALKING:
			handle_walking(input_axis, delta)
		player_state.RUNNING:
			pass
		player_state.ATTACKING:
			pass

func handle_walking(input_axis, delta):
	if input_axis.length() > 0:
		player.velocity = player.velocity.move_toward(input_axis * SPEED, ACCELERATION * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func handle_running():
	pass

func handle_attacking():
	pass

func update_animation(input_axis):
	if input_axis.x > 0 :
		animated_sprite_2d.play("right")
	elif input_axis.y > 0:
		animated_sprite_2d.play("down")
	elif input_axis.x < 0:
		animated_sprite_2d.play("left")
	elif input_axis.x == 0 and input_axis.y < 0:
		animated_sprite_2d.play("up")
