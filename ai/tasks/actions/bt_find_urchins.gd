extends BTAction

@export var search_group: String = "has_urchins"
@export var bb_target: StringName = "target"

func _tick(_delta: float) -> Status:
	var crab = agent as Crabby
	var urchin_list = agent.get_tree().get_nodes_in_group(search_group)
	# Flatten: get all urchins from all algae that have them
	var all_urchins = agent.get_tree().get_nodes_in_group("urchins")
	all_urchins = all_urchins.filter(func(u): return is_instance_valid(u))
	if all_urchins.is_empty():
		return FAILURE
	all_urchins.sort_custom(func(a, b):
		return crab.global_position.distance_to(a.global_position) < \
			   crab.global_position.distance_to(b.global_position)
	)
	blackboard.set_var(bb_target, all_urchins.front())
	return SUCCESS
