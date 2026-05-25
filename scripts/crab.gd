extends SeaCreature
class_name Crabby

func _ready() -> void:
	search_group = "urchins"
	social_group = "crabs"
	wander_group = "algae"
	await super._ready()

func get_creature_group() -> String:
	return "crabs"
