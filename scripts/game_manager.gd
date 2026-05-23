extends Node2D

@export var algae_scene: PackedScene
@onready var popup := $AlgaePopup

var place_position := Vector2.ZERO

func _ready():
	popup.add_item("Plant Algae", 0)
	# add more types later: popup.add_item("Kelp", 1)
	popup.id_pressed.connect(_on_popup_item_selected)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			place_position = get_global_mouse_position()
			popup.popup(Rect2(event.position, Vector2.ZERO))

func _on_popup_item_selected(id):
	match id:
		0: spawn_algae(place_position)

func spawn_algae(pos: Vector2):
	var algae = algae_scene.instantiate()
	algae.global_position = pos
	$Creatures.add_child(algae)
