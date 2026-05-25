extends BTCondition

func _tick(_delta: float) -> Status:
	return SUCCESS if (agent as SeaCreature).is_hungry() else FAILURE
