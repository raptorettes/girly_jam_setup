extends Node2D

@export var urchin_sprites: Array[Texture2D] 

var growth_stage := 0

@onready var sprite := $UrchinSprite
@onready var growth_timer := $GrowthTimer


func _ready():
	sprite.texture = urchin_sprites[0]
	growth_timer.wait_time = 5.0
	growth_timer.start()


func _on_growth_timer_timeout():
	if growth_stage < 2:
		growth_stage += 1
		sprite.texture = urchin_sprites[growth_stage]
	if growth_stage == 2:
		growth_timer.stop() 
