extends BTAction

func _tick(_delta: float) -> Status:
	var creature = agent as SeaCreature
	creature.target = null
	var food_list = agent.get_tree().get_nodes_in_group(creature.search_group)
	food_list = food_list.filter(func(f): return is_instance_valid(f))
	if food_list.is_empty():
		return FAILURE
	creature.target = food_list.pick_random()
	return SUCCESS
