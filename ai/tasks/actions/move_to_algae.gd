extends BTAction

var _eating := false
var _eat_timer := 0.0
const EAT_DELAY = 1.0

func _enter() -> void:
	_eating = false
	_eat_timer = 0.0
	var target = blackboard.get_var("target_algae", null)
	if target:
		agent.move_to(target.global_position)

func _tick(delta: float) -> Status:
	var target = blackboard.get_var("target_algae", null)
	if not is_instance_valid(target):
		return FAILURE
	if not agent.nav_agent.is_navigation_finished():
		return RUNNING
	_eating = true
	_eat_timer += delta
	if _eat_timer >= EAT_DELAY:
		target.queue_free()
		return SUCCESS
	return RUNNING
