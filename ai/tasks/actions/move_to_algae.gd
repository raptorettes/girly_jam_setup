extends BTAction

var _eating := false
var _eat_timer := 0.0
const EAT_DELAY = 1.0

func _enter() -> void:
	_eating = false
	_eat_timer = 0.0
	var crab = agent as Crabby
	if crab.target:
		agent.move_to(crab.target.global_position)

func _tick(delta: float) -> Status:
	var crab = agent as Crabby
	if crab.target:
		if not is_instance_valid(crab.target):
			return FAILURE
		if not agent.nav_agent.is_navigation_finished():
			return RUNNING
		else:
			_eating = true
			_eat_timer += delta
			if _eat_timer >= EAT_DELAY:
				crab.eat_algae()
				return SUCCESS
	else:
		return FAILURE
	return RUNNING
