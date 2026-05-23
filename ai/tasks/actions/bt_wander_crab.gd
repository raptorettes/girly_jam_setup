@tool
extends BTAction

@export var wander_radius: float = 10.0

func _tick(delta: float) -> Status:
	var crab = agent as CharacterBody2D
	var random_offset = Vector2(
		randf_range(-wander_radius, wander_radius),
		randf_range(-wander_radius, wander_radius)
	)
	var target = crab.global_position + random_offset
	blackboard.set_var("wander_target", target)
	return SUCCESS
