extends CharacterBody2D

@onready var nav_agent := $NavigationAgent2D

const SPEED = 50.0

func move_to(target_pos: Vector2):
	nav_agent.target_position = target_pos

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	var next = nav_agent.get_next_path_position()
	velocity = (next - global_position).normalized() * SPEED
	move_and_slide()
