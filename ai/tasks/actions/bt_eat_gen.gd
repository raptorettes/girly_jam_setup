extends BTAction

@export var bb_target: StringName = "target"
@export var eat_delay: float = 0.8

var _timer := 0.0

func _enter() -> void:
	_timer = 0.0

func _tick(delta: float) -> Status:
	var target = blackboard.get_var(bb_target, null)
	if not is_instance_valid(target):
		return FAILURE
	_timer += delta
	if _timer >= eat_delay:
		target.die()
		blackboard.set_var(bb_target, null)
		return SUCCESS
	return RUNNING
