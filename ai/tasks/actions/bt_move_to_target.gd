extends BTAction

func _enter() -> void:
	var creature = agent as SeaCreature
	if creature.wander_target != Vector2.ZERO:
		creature.move_to(creature.wander_target)
	elif is_instance_valid(creature.social_target):
		# snapshot position, don't chase
		creature.move_to(creature.social_target.global_position)
		creature.social_target = null
	elif is_instance_valid(creature.target):
		creature.move_to(creature.target.global_position)

func _tick(_delta: float) -> Status:
	var creature = agent as SeaCreature
	
	# update destination for moving food targets
	if is_instance_valid(creature.target):
		creature.move_to(creature.target.global_position)
		if creature.has_arrived():
			creature.stop_moving()
			return SUCCESS
	elif creature.wander_target != Vector2.ZERO:
		if creature.has_arrived():
			creature.wander_target = Vector2.ZERO
			creature.stop_moving()
			return SUCCESS
	else:
		creature.stop_moving()
		return FAILURE
		
	return RUNNING

func _exit() -> void:
	(agent as SeaCreature).stop_moving()
