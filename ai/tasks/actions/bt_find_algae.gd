extends BTAction

func _tick(delta: float) -> Status:
	var algae_list = agent.get_tree().get_nodes_in_group("algae")
	if algae_list.is_empty():
		return FAILURE
	var crab = agent as Crabby
	var urchind = algae_list.filter(func(a: Algae): return a.urchin_popuplation > 0)
	urchind.sort_custom(func(a, b): 
		return a if crab.global_position.distance_to(a.global_position) < crab.global_position.distance_to(b.global_position) else b
	)
	var nearest : Algae = urchind.front()
	crab.set_target(nearest)
	return SUCCESS
