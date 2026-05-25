extends Node2D
class_name Algae

signal urchin_count_update(amount: int)

@export var algae_sprites: Array[Texture2D]
@export var sick_sprite: Texture2D
@export var urchin_scene: PackedScene
@export var urchin_sprites: Array[Texture2D]
@export var sprite: Sprite2D
@export var growth_timer: Timer
@export var urchin_timer: Timer
@export var urchins_node: Node2D
@export var recovery_timer: Timer

var growth_stage := 0
var urchin_population := 0
const MAX_URCHINS = 5
const URCHIN_SPREAD = 5.0

func _ready() -> void:
	add_to_group("algae")
	sprite.texture = algae_sprites[0]
	growth_timer.wait_time = 5.0
	growth_timer.start()
	urchin_timer.wait_time = 10.0
	urchin_timer.start()
	recovery_timer.wait_time = 10.0
	recovery_timer.one_shot = true

func _on_growth_timer_timeout() -> void:
	if growth_stage < 2:
		growth_stage += 1
		sprite.texture = algae_sprites[growth_stage]
	if growth_stage == 2:
		growth_timer.stop()

func _on_urchin_spawn_timer_timeout() -> void:
	print("urchin timer fired, population: ", urchin_population)
	if Globals.allow_urchins:
		spawn_urchin()

func spawn_urchin() -> void:
	if urchin_population >= MAX_URCHINS:
		sprite.texture = sick_sprite
		remove_from_group("has_urchins")
		urchin_timer.stop()
		return

	var urchin: Urchin = urchin_scene.instantiate()
	urchin.parent_algae = self
	var offset = Vector2(randf_range(-URCHIN_SPREAD, URCHIN_SPREAD),
						 randf_range(-URCHIN_SPREAD, URCHIN_SPREAD))
	urchin.position = offset
	urchins_node.add_child(urchin)
	urchin.sprite.texture = urchin_sprites.pick_random()
	urchin_population += 1
	urchin_count_update.emit(1)
	_update_sprite()
	_update_groups()

func remove_urchin(urchin: Urchin) -> void:
	print("REMOVE URCHIN CALLED")
	print("remove_urchin called, population before: ", urchin_population)
	if urchin_population > 0:
		urchin_population -= 1
		urchin_count_update.emit(-1)
		urchin_timer.stop()  # stop spawning immediately
		_update_sprite()
		_update_groups()
		recovery_timer.start()  # always start recovery, not just when timer stopped
	else:
		print("remove_urchin called but population is 0!")

func _on_recovery_timer_timeout() -> void:
	_update_sprite()
	urchin_timer.wait_time = 5.0
	urchin_timer.start()

func _update_sprite() -> void:
	if urchin_population >= MAX_URCHINS:
		sprite.texture = sick_sprite
	else:
		sprite.texture = algae_sprites[min(growth_stage, algae_sprites.size() - 1)]

func _update_groups() -> void:
	if urchin_population > 0:
		add_to_group("has_urchins")
	else:
		remove_from_group("has_urchins")
