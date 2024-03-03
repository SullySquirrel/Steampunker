extends CharacterBody2D

# Node references
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var camera_2d = $Camera2D
@onready var sprite_2d = $Sprite2D
@onready var player_inventory_ui = $Camera2D/PlayerInventoryUI

# Export variables for inspector
@export var movement_data: Resource
@export var player_stats: Resource

# Player state machine
enum {
	WALK,
	ATTACK,
	INVENTORY
}

# Sets default state to walk
var state = WALK
var is_inventory_open = false

func _ready():
	camera_2d.enabled = true
	player_inventory_ui.visible = false
	is_inventory_open = false
	state = WALK
	# Set this node as the player node
	Global.set_player_reference(self)

func _process(delta):
	# Processes the state functionality
	match state:
		WALK:
			walking_state(delta)
		ATTACK:
			attack_state()
		INVENTORY:
			inventory_move_state()

func _input(event):
	if event.is_action_pressed("inventory") and is_inventory_open == false:
		is_inventory_open = true
		player_inventory_ui.visible = !player_inventory_ui.visible
		state = INVENTORY
	elif  event.is_action_pressed("inventory") and is_inventory_open == true:
		is_inventory_open = false
		player_inventory_ui.visible = !player_inventory_ui.visible
		state = WALK

func normalize(input_vector) -> Vector2:
	# Ensures that the value of the vector does not go past one
	var return_vector = input_vector
	if return_vector == Vector2.ZERO:
		return return_vector
	else:
		# Pythagorean theorum
		var vector_length = sqrt(pow(return_vector.x, 2) + pow(return_vector.y, 2))
		return_vector.x = return_vector.x / vector_length
		return_vector.y = return_vector.y / vector_length
		return return_vector

func walking_state(delta):
	var input_vector = Input.get_vector("left", "right", "up", "down")
	input_vector = input_vector.normalized()
	
	# Moves the character and updates the animations
	if input_vector != Vector2.ZERO :
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		animation_state.travel("Walk")
		velocity = velocity.move_toward(input_vector * movement_data.MAX_SPEED, movement_data.ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, movement_data.FRICTION * delta)
	move_and_slide()

func attack_state():
	# todo: when attack buttan is pressed switch to attack state, attack, and then revert back to the walk state
	pass

func inventory_move_state():
	pass
