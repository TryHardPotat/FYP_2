extends Node

var selected_character = ""
var base_upgrade_cost = 50  # Starting cost for all upgrades

var scout_base_stats = {
	"health": 100,
	"damage": 5,
	"speed": 250,
	"health_level": 0,
	"damage_level": 0,
	"gold": 0,
	"speed_level": 0,
	"health_cost": 50,
	"damage_cost": 50,
	"speed_cost": 50
}

var slingshot_base_stats = {
	"health": 75,
	"damage": 5,
	"speed": 275,
	"health_level": 0,
	"damage_level": 0,
	"gold": 0,
	"speed_level": 0,
	"health_cost": 50,
	"damage_cost": 50,
	"speed_cost": 50
}

var spellcaster_base_stats = {
	"health": 50,
	"damage": 10,
	"speed": 225,
	"health_level": 0,
	"damage_level": 0,
	"gold": 0,
	"speed_level": 0,
	"health_cost": 50,
	"damage_cost": 50,
	"speed_cost": 50
}

# Main dictionary to store all characters' stats
var all_characters_stats = {
	"Scout": {},
	"Slingshot": {},
	"Spellcaster": {}
}

# Current character's stats reference
var stats = {}

func _ready():
	load_stats()

func select_character(character_name: String):
	selected_character = character_name
	
	# If this character hasn't been initialized yet, use base stats
	if all_characters_stats[character_name].is_empty():
		match character_name:
			"Scout":
				all_characters_stats[character_name] = scout_base_stats.duplicate()
			"Slingshot":
				all_characters_stats[character_name] = slingshot_base_stats.duplicate()
			"Spellcaster":
				all_characters_stats[character_name] = spellcaster_base_stats.duplicate()
	
	# Point stats reference to the correct character's stats
	stats = all_characters_stats[character_name]
	
	print("Selected character: ", character_name)
	print("Initial stats: ", stats)

func calculate_upgrade_cost(current_level: int) -> int:
	# Increase cost by 50% for each level
	return base_upgrade_cost + (base_upgrade_cost * (current_level * 0.5)) as int

func can_afford_upgrade(cost: int) -> bool:
	return stats.gold >= cost

func update_stat(stat_name: String, value):
	if stats.has(stat_name):
		stats[stat_name] = value
		print(stat_name, " updated to ", value)
	else:
		print("Stat ", stat_name, " does not exist for ", selected_character)

func attempt_upgrade(stat_type: String) -> bool:
	var level_key = stat_type + "_level"
	var cost_key = stat_type + "_cost"
	
	if not stats.has(level_key) or not stats.has(cost_key):
		return false
		
	var current_cost = stats[cost_key]
	
	if can_afford_upgrade(current_cost):
		# Deduct gold
		stats.gold -= current_cost
		
		# Increase stat based on type
		match stat_type:
			"health":
				stats.health += 10  # +10 health per upgrade
			"damage":
				stats.damage += 2   # +2 damage per upgrade
			"speed":
				stats.speed += 5    # +5 speed per upgrade
		
		# Increase level
		stats[level_key] += 1
		
		# Calculate and update new cost
		stats[cost_key] = calculate_upgrade_cost(stats[level_key])
		
		# Save the changes
		save_stats()
		return true
		
	return false

func save_stats():
	var save_data = {
		"all_characters_stats": all_characters_stats,
		"selected_character": selected_character
	}
	
	var save_file = FileAccess.open("user://game_save.json", FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)
	save_file.close()
	
	print("All stats saved: ", save_data)
	return true

func load_stats():
	if not FileAccess.file_exists("user://game_save.json"):
		print("No save file found - Using base stats")
		return false
	
	var save_file = FileAccess.open("user://game_save.json", FileAccess.READ)
	var json_string = save_file.get_line()
	var save_data = JSON.parse_string(json_string)
	save_file.close()
	
	if save_data:
		all_characters_stats = save_data.all_characters_stats
		selected_character = save_data.selected_character
		
		if selected_character != "":
			stats = all_characters_stats[selected_character]
			Global.gold = stats.gold  # Initialize Global.gold with the saved value
		
		print("All stats loaded: ", all_characters_stats)
		print("Current character: ", selected_character)
		return true
	
	return false
