extends BTAction

func _tick(_delta: float) -> Status:
	var creature = agent as SeaCreature
	creature.social_target = null
	var others = agent.get_tree().get_nodes_in_group(creature.social_group)
	others = others.filter(func(c): return c != creature and is_instance_valid(c))
	if others.is_empty():
		return FAILURE
	others.sort_custom(func(a, b):
		return creature.global_position.distance_to(a.global_position) < \
			   creature.global_position.distance_to(b.global_position)
	)
	var pool = others.slice(0, min(3, others.size()))
	creature.social_target = pool.pick_random()
	return SUCCESS
