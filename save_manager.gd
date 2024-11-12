extends Node

var selected_character = ""
var scout_base_stats = {
	"health": 100,
	"damage" : 5,
	"gold": 0
}
var slingshot_base_stats = {
	"health": 75,
	"damage" : 5,
	"gold": 0
}
var spellcaster_base_stats = {
	"health": 50,
	"damage" : 5,
	"gold": 0
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
	# Load all saved data when the game starts
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

func save_stats():
	# Create the save dictionary
	var save_data = {
		"all_characters_stats": all_characters_stats,
		"selected_character": selected_character
	}
	
	# Save to file
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
		
		# If we have a selected character, update the stats reference
		if selected_character != "":
			stats = all_characters_stats[selected_character]
		
		print("All stats loaded: ", all_characters_stats)
		print("Current character: ", selected_character)
		return true
	
	return false

func update_stat(stat_name: String, value: float):
	if stats.has(stat_name):
		stats[stat_name] = value
		# Since stats is a reference, all_characters_stats is automatically updated
		print("Stat Updated for ", selected_character, " - ", stat_name, " is now: ", value)
		save_stats()  # Auto-save whenever a stat is updated
		return true
	return false
