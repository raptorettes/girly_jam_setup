extends Node2D

@export var algae_scene: PackedScene
@export var crab_scene: PackedScene

@export var mermaids_want_crabs:= 5
@export var urchin_wants_algae:= 5
@export var crab_wants_urchin:= 25
#@onready var popup := $AlgaePopup

var allow_urchins: bool = false
var allow_crabs: bool = false

var total_algae_count:= 0
var total_urchin_count:= 0
var total_crab_count:= 0

var place_position := Vector2.ZERO

enum WHAT {algae, urchin, crab}

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			place_position = get_global_mouse_position()
			spawn_algae(place_position)


func update_urchin_count():	
	total_urchin_count+=1
	pass

func spawn_algae(pos: Vector2):
	var algae: Algae = algae_scene.instantiate()
	algae.global_position = pos
	algae.urchin_count_update.connect(update_urchin_count)
	$Creatures.add_child(algae)
	total_algae_count += 1
	check_game_state(WHAT.algae)
	

func check_game_state(what: WHAT):
	match what:
		WHAT.algae:
			if not allow_urchins and total_algae_count > 5 and total_algae_count%5 == 0:
				#urchin popup message
				pass
	

func on_button_allow_urchins():
	allow_urchins = true
