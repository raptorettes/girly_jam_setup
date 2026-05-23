extends BTAction

func _tick(delta: float) -> Status:
	var algae_list = agent.get_tree().get_nodes_in_group("algae")
	print("algae found: ", algae_list.size())
	if algae_list.is_empty():
		return FAILURE
	var crab = agent as CharacterBody2D
	var nearest = algae_list.reduce(func(a, b): 
		return a if crab.global_position.distance_to(a.global_position) < crab.global_position.distance_to(b.global_position) else b
	)
	blackboard.set_var("target_algae", nearest)
	print("target set: ", nearest)
	return SUCCESS
