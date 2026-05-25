extends BTAction

func _tick(_delta: float) -> Status:
	var creature = agent as SeaCreature
	var wander_list = agent.get_tree().get_nodes_in_group(creature.wander_group)
	if wander_list.is_empty():
		var offset = Vector2(randf_range(-creature.wander_radius, creature.wander_radius),
							 randf_range(-creature.wander_radius, creature.wander_radius))
		creature.wander_target = creature.global_position + offset
	else:
		creature.wander_target = wander_list.pick_random().global_position
	return SUCCESS
