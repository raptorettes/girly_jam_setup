@tool
extends BTAction

var _started := false

func _enter() -> void:
	_started = false

func _tick(delta: float) -> Status:
	var crab = agent as CharacterBody2D
	var target = blackboard.get_var("wander_target", crab.global_position)
	
	if not _started:
		crab.move_to(target)
		_started = true
		return RUNNING
	
	if crab.nav_agent.is_navigation_finished():
		return SUCCESS
	return RUNNING
