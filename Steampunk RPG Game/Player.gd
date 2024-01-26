extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var camera_2d = $Camera2D

@export var movement_data: Resource
@export var player_stats: Resource

enum {
	WALK
}

var state = WALK

func _ready():
	camera_2d.enabled = true

func _process(delta):
	match state:
		WALK:
			walking_state(delta)

func normalize(input_vector) -> Vector2:
	var return_vector = input_vector
	if return_vector == Vector2.ZERO:
		return return_vector
	else:
		var vector_length = sqrt(pow(return_vector.x, 2) + pow(return_vector.y, 2))
		return_vector.x = return_vector.x / vector_length
		return_vector.y = return_vector.y / vector_length
		return return_vector

func walking_state(delta):
	var input_vector = Input.get_vector("left", "right", "up", "down")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO :
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		animation_state.travel("Walk")
		velocity = velocity.move_toward(input_vector * movement_data.MAX_SPEED, movement_data.ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, movement_data.FRICTION * delta)
	move_and_slide()
