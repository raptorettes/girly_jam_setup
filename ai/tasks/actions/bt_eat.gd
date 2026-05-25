extends BTAction
var _timer := 0.0

func _enter() -> void:
	_timer = 0.0
	print("bt_eat ENTER: target: ", (agent as SeaCreature).target)

func _tick(delta: float) -> Status:
	var creature = agent as SeaCreature
	if not is_instance_valid(creature.target):
		print("bt_eat TICK: target invalid, returning FAILURE")
		return FAILURE
	_timer += delta
	print("bt_eat TICK: timer: ", _timer, " delay: ", creature.eat_delay, " target: ", creature.target)
	if _timer >= creature.eat_delay:
		print("bt_eat: calling on_eat on: ", creature.target)
		creature.on_eat(creature.target)
		creature.target = null
		creature.reset_hunger()
		return SUCCESS
	return RUNNING
