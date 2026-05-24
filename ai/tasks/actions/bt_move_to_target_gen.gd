extends BTAction

@export var bb_target: StringName = "target"
@export var arrival_distance: float = 10.0

func _enter() -> void:
	var target = blackboard.get_var(bb_target, null)
	if is_instance_valid(target):
		agent.move_to(target.global_position)

func _tick(_delta: float) -> Status:
	var target = blackboard.get_var(bb_target, null)
	if not is_instance_valid(target):
		return FAILURE
	if agent.nav_agent.is_navigation_finished():
		return SUCCESS
	return RUNNING
