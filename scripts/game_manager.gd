extends Node2D

@export var algae_scene: PackedScene
@export var crab_scene: PackedScene

@export var urchin_wants_algae:= 5
@export var crab_wants_urchin:= 25
@export var mermaids_want_crabs:= 5


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


func spawn_algae(pos: Vector2):
	var algae: Algae = algae_scene.instantiate()
	algae.global_position = pos
	algae.urchin_count_update.connect(update_urchin_count)
	$Creatures.add_child(algae)
	total_algae_count += 1
	if not Globals.allow_urchins:
		check_game_state(WHAT.algae)


func update_urchin_count():
	total_urchin_count+=1
	if not Globals.allow_crabs:
		check_game_state(WHAT.urchin)


func spawn_crab():
	var crab = crab_scene.instantiate()
	crab.global_position = global_position #TODO make it spawn somewhere randomly?
	$Creatures.add_child(crab)
	total_crab_count += 1
	check_game_state(WHAT.crab)


func check_game_state(what: WHAT):
	match what:
		WHAT.algae:
			if total_algae_count > urchin_wants_algae and total_algae_count%5 == 0:
				#urchin popup message
				pass
		WHAT.urchin:
			if total_urchin_count > crab_wants_urchin:
				#crab popup message
				total_algae_count -= crab_wants_urchin
		WHAT.crab:
			if total_crab_count > mermaids_want_crabs:
				#mermaid popup message/end game
				pass


func on_button_allow_urchins():
	Globals.allow_urchins = true

func on_button_allow_crabs():
	Globals.allow_crabs = true
	spawn_crab()
