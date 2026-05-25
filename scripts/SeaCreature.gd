extends CharacterBody2D
class_name SeaCreature

var target: Node2D = null        # food - always chase
var social_target: Node2D = null # socialise - move to last known position only
var wander_target: Vector2 = Vector2.ZERO
var hunger: float = 0.0
var hunger_threshold: float = 0.0
var _steering_target: Vector2 = Vector2.ZERO
var _is_moving: bool = false

@export var speed: float = 50.0
@export var wander_radius: float = 80.0
@export var eat_delay: float = 0.8
@export var min_hunger_time: float = 5.0
@export var max_hunger_time: float = 40.0
@export var search_group: String = ""
@export var social_group: String = ""
@export var wander_group: String = ""
@export var arrival_distance: float = 30.0

# world bounds - set these to match your scene
@export var bounds_min: Vector2 = Vector2(30, 10)
@export var bounds_max: Vector2 = Vector2(450, 285)

func _ready() -> void:
	add_to_group(get_creature_group())
	_reset_hunger_threshold()

func _physics_process(delta):
	hunger += delta
	if _is_moving:
		var direction = (_steering_target - global_position).normalized()
		velocity = velocity.lerp(direction * speed, delta * 5.0)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * 5.0)
	velocity += _get_separation_force()
	global_position.x = clamp(global_position.x, bounds_min.x, bounds_max.x)
	global_position.y = clamp(global_position.y, bounds_min.y, bounds_max.y)
	move_and_slide()

func _get_separation_force() -> Vector2:
	var force = Vector2.ZERO
	var neighbours = get_tree().get_nodes_in_group(get_creature_group())
	for other in neighbours:
		if other == self:
			continue
		var diff = global_position - other.global_position
		var dist = diff.length()
		if dist < 20.0 and dist > 0:
			force += diff.normalized() * (20.0 - dist) * 0.5
	return force

func move_to(pos: Vector2) -> void:
	_steering_target = pos
	_is_moving = true

func stop_moving() -> void:
	_is_moving = false

func has_arrived() -> bool:
	return global_position.distance_to(_steering_target) <= arrival_distance

func is_hungry() -> bool:
	return hunger >= hunger_threshold

func reset_hunger() -> void:
	hunger = 0.0
	_reset_hunger_threshold()

func _reset_hunger_threshold() -> void:
	hunger_threshold = randf_range(min_hunger_time, max_hunger_time)

func get_creature_group() -> String:
	return "creatures"

func on_eat(target_node: Node2D) -> void:
	print("on_eat called on: ", target_node)
	target_node.die()
