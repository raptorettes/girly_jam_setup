extends SeaCreature
class_name Otter

func _ready() -> void:
	search_group = "crabs"
	social_group = "otters"
	await super._ready()

func get_creature_group() -> String:
	return "otters"
