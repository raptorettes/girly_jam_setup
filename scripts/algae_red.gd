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

var growth_stage := 0
var urchin_popuplation:= 0

func _ready():
	sprite.texture = algae_sprites[0]
	growth_timer.wait_time = 5.0
	growth_timer.start()
	urchin_timer.wait_time = 5.0
	urchin_timer.start()


func _on_growth_timer_timeout():
	if growth_stage < 2:
		growth_stage += 1
		sprite.texture = algae_sprites[growth_stage]
	if growth_stage == 2:
		growth_timer.stop()  # fully grown, stop timer


func _on_urchin_spawn_timer_timeout() -> void:
	if Globals.allow_urchins:
		spawn_urchin()
	

func spawn_urchin() -> void:
	if urchin_popuplation == 5:
		sprite.texture = sick_sprite
		urchin_timer.stop()
		return
	if urchin_popuplation < 5:
		sprite.texture = algae_sprites.back()
	var urchin: Urchin = urchin_scene.instantiate()
	urchins_node.add_child(urchin)
	urchin.sprite.texture = urchin_sprites.pick_random()
	urchin_count_update.emit(1)
	urchin_popuplation+=1


func kill_urchin() -> void:
	if urchin_popuplation > 0:
		urchins_node.get_child(0).queue_free()
		urchin_popuplation -=1
		urchin_count_update.emit(-1)



func _on_area_2d_body_entered(_body: Node2D) -> void:
	kill_urchin()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	urchin_timer.start()
