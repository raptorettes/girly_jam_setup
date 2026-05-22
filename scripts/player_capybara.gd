extends CharacterBody2D

@export var move_speed: float = 10

@onready var sprite = $Sprite2D
@onready var anim_player = $AnimationPlayer

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	if input_direction != Vector2.ZERO:
		anim_player.play("walk_right")
		if input_direction.x < 0:
			sprite.flip_h = true
		elif input_direction.x > 0:
			sprite.flip_h = false
	else:
		anim_player.play("idle_right")
	
	velocity = input_direction * move_speed
	move_and_slide()
