extends Node2D
class_name Algae

signal urchin_count_update(amount: int)

@export var algae_sprites: Array[Texture2D] 
@export var urchin_scene: PackedScene
@export var urchin_sprites: Array[Texture2D] 


@onready var sprite := $AlgaeSprite
@onready var growth_timer := $GrowthTimer
@onready var urchin_timer := $UrchinSpawnTimer

var growth_stage := 0
var urchin_popuplation:= 0

func _ready():
	sprite.texture = algae_sprites[0]
	growth_timer.wait_time = 5.0
	growth_timer.start()
	urchin_timer.wait_time = 5.0
	#urchin_timer.one_shot = true
	urchin_timer.start()

func _on_growth_timer_timeout():
	if growth_stage < 2:
		growth_stage += 1
		sprite.texture = algae_sprites[growth_stage]
	if growth_stage == 2:
		growth_timer.stop()  # fully grown, stop timer


func _on_urchin_spawn_timer_timeout() -> void:
	print("timeot")
	if Globals.allow_urchins:
		spawn_urchin()
	

func spawn_urchin() -> void:
	var urchin: Urchin = urchin_scene.instantiate()
	add_child(urchin)
	urchin.sprite.texture = urchin_sprites[urchin_popuplation]
	urchin_popuplation+=1
	urchin_count_update.emit(1)
	if urchin_popuplation == 5:
		urchin_timer.stop()

func urchin_eaten():
	urchin_count_update.emit(-1)
	##TODO
