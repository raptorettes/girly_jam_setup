extends Node2D

@export var algae_scenes: Array[PackedScene]
@export var crab_scene: PackedScene
@export var urchin_popup: PanelContainer
@export var crab_popup: PanelContainer
@export var final_popup: PanelContainer

@export var urchin_wants_algae:= 5
@export var crab_wants_urchin:= 25
@export var mermaids_want_crabs:= 5

var showing_menu: bool = false

var total_algae_count:= 0
var total_urchin_count:= 0
var total_crab_count:= 0

var place_position := Vector2.ZERO

enum WHAT {algae, urchin, crab}

func _ready():
	show_urchin_popup(false)
	show_crab_popup(false)
	show_final_popup(false)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			place_position = get_global_mouse_position()
			spawn_algae(place_position)


func spawn_algae(pos: Vector2):
	var algae: Algae = algae_scenes[randi_range(0,algae_scenes.size())-1].instantiate()
	algae.global_position = pos
	algae.urchin_count_update.connect(update_urchin_count)
	$Creatures.add_child(algae)
	total_algae_count += 1
	print(total_algae_count)
	if not Globals.allow_urchins:
		check_game_state(WHAT.algae)


func update_urchin_count(amount: int):
	total_urchin_count+= amount
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
			if total_algae_count >= urchin_wants_algae and total_algae_count%5 == 0:
				show_urchin_popup(true)
				pass
		WHAT.urchin:
			if total_urchin_count >= crab_wants_urchin:
				show_crab_popup(true)
				total_algae_count -= crab_wants_urchin
		WHAT.crab:
			if total_crab_count >= mermaids_want_crabs:
				show_final_popup(true)
				pass

func show_urchin_popup(to_show:bool):
	urchin_popup.hide()
	if to_show:
		urchin_popup.show()
		print("show urchin popup")

func show_crab_popup(to_show:bool):
	crab_popup.hide()
	if to_show:
		crab_popup.show()

func show_final_popup(to_show:bool):
	final_popup.hide()
	if to_show:
		final_popup.hide()

func on_button_allow_urchins():
	Globals.allow_urchins = true
	print(Globals.allow_urchins)
	show_urchin_popup(false)

func on_button_allow_crabs():
	Globals.allow_crabs = true
	spawn_crab()
	show_crab_popup(false)


func _on_urchin_no_button_pressed() -> void:
	show_urchin_popup(false)

func _on_crab_no_button_pressed():
	show_crab_popup(false)

func _on_yay_button_pressed():
	get_tree().reload_current_scene()
