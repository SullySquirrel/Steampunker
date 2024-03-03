extends Control

@onready var icon = $TextureRect/Icon
@onready var slot_button = $SlotButton
@onready var texture_rect = $TextureRect

# Slot item
var item = null

func set_empty():
	icon.texture = null

func set_item(new_item):
	item = new_item
	icon.texture = item["texture"] 


func _on_slot_button_mouse_entered():
	texture_rect.modulate = Color(.6,.6,.6,1)


func _on_slot_button_mouse_exited():
	texture_rect.modulate = Color(1,1,1,1)
