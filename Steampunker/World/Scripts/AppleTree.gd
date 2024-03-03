extends Node2D

var state = "noApples" #noApples, apples
var player_in_area = false

func _ready():
	if state == "noApples":
		$growthTimer.start()

func _process(delta):
	if state == "noApples":
		$AnimatedSprite2D.play("noApples")
	if state == "apples":
		$AnimatedSprite2D.play("noApples") #change back to "Apples"
		if player_in_area:
			if Input.is_action_just_pressed("interact"):
				state = "noApples"
				drop_apple()

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func _on_growth_timer_timeout():
	if  state == "noApples":
		state = "apples"

func drop_apple():
	await get_tree().create_timer(3).timeout
	$growthTimer.start()
