extends Node

## Spawner Requirements
var character_scenes = {
	"Scout": preload("res://scenes/entities/scout.tscn"),
	"Slingshot": preload("res://scenes/entities/slingshot.tscn"),
	"Spellcaster": preload("res://scenes/entities/spellcaster.tscn")
}
var selected_character : PackedScene = null
var dungeon_width : int = 5
var dungeon_height : int = 5

## Player Level & Experience
var player_level = 1
var player_exp = 0

## Player Gold
var current_run_gold : int = 0
var gold : int = 0

## Subclass Additional Stats
var subclass_health_multiplier : float = 1.0
var subclass_speed_multiplier : float = 1.0
var subclass_damage_multiplier : float = 1.0

func apply_subclass_multiplier(subclass):
	if subclass == "Athlete":
		print("Applying Athlete Multiplier")
		subclass_health_multiplier = 1.05
		subclass_speed_multiplier = 1.1
		subclass_damage_multiplier = 1.0
	elif subclass == "Tank":
		print("Applying Tank Multiplier")
		subclass_health_multiplier = 1.2
		subclass_speed_multiplier = 0.8
		subclass_damage_multiplier = 1.0
	elif subclass == "GlassCannon":
		print("Applying GlassCannon Multiplier")
		subclass_health_multiplier = 0.8
		subclass_speed_multiplier = 1.0
		subclass_damage_multiplier = 1.2
	else:
		print("Invalid Class, Loading Default Multiplier")
		subclass_health_multiplier = 1.0
		subclass_speed_multiplier = 1.0
		subclass_damage_multiplier = 1.0
	
	# Add debug print to verify values
	print("Current Health Multiplier: ", subclass_health_multiplier)
	print("Current Speed Multiplier: ", subclass_speed_multiplier)
	print("Current Damage Multiplier: ", subclass_damage_multiplier)
