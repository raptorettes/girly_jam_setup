extends CharacterBody2D
@export var navigation_region: NavigationRegion2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var move_speed = 40.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func move_to(target: Vector2) -> void:
	nav_agent.target_position = target

func is_navigation_finished() -> bool:
	return nav_agent.is_navigation_finished()
#
#func set_anim_state(state: StringName) -> void:
	#anim_tree["parameters/conditions/" + state] = true

func _physics_process(delta: float) -> void:
	move_and_slide()
