extends Node2D
class_name Urchin

@export var sprite: Sprite2D
var parent_algae: Algae

func _ready() -> void:
	add_to_group("urchins")

func die() -> void:
	if parent_algae:
		parent_algae.remove_urchin(self)
	queue_free()
