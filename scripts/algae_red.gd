extends Node2D

@export var algae_sprites: Array[Texture2D] 

var growth_stage := 0

@onready var sprite := $AlgaeSprite
@onready var growth_timer := $GrowthTimer
@onready var urchin_timer := $UrchinSpawnTimer

func _ready():
	sprite.texture = algae_sprites[0]
	growth_timer.wait_time = 5.0
	growth_timer.start()
	urchin_timer.wait_time = 30.0
	urchin_timer.one_shot = true
	urchin_timer.start()

func _on_growth_timer_timeout():
	if growth_stage < 2:
		growth_stage += 1
		sprite.texture = algae_sprites[growth_stage]
	if growth_stage == 2:
		growth_timer.stop()  # fully grown, stop timer


#
#func _on_urchin_spawn_timer_timeout() -> void:
	#GameManager.spawn_urchin(global_position)
