extends CharacterBody2D
class_name Crabby

@onready var nav_agent := $NavigationAgent2D

const SPEED = 50.0
var age: int = 0
var target: Algae 

func _ready():
	await get_tree().process_frame

func move_to(target_pos: Vector2):
	nav_agent.target_position = target_pos

func set_target(t: Algae) -> void:
	target = t
	
func eat_algae() -> void:
	target.kill_urchin()
	
func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	var next = nav_agent.get_next_path_position()
	velocity = (next - global_position).normalized() * SPEED
	move_and_slide()
