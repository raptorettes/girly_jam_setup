extends SeaCreature
class_name Nudibranch

func _ready() -> void:
	search_group = "urchins"  # or whatever nudibranchs eat
	social_group = "nudibranchs"
	await super._ready()

func get_creature_group() -> String:
	return "nudibranchs"
