extends Control

@onready var load_game_button = $VBoxContainer/LoadGameButton

func _ready():
	load_game_button.grab_focus()

func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://World/Scenes/world.tscn")

func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("res://World/Scenes/world.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://UI/Scenes/options_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
