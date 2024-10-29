# global.gd
extends Node

var selected_character = ""

var scout_base_stats = {
	"health": 100
}

var slingshot_base_stats = {
	"health": 75
}

var spellcaster_base_stats = {
	"health": 50
}

# This will hold the current character's stats
var stats = {}

# Call this when selecting a character
func select_character(character_name: String):
	selected_character = character_name
	
	# Use match instead of if/elif for cleaner syntax
	match character_name:
		"Scout":
			stats = scout_base_stats.duplicate()  # Use duplicate() to avoid modifying base stats
		"Slingshot":
			stats = slingshot_base_stats.duplicate()
		"Spellcaster":
			stats = spellcaster_base_stats.duplicate()
	
	print("Selected character: ", character_name)
	print("Initial stats: ", stats)
	
	# Load any saved stats for this character
	load_stats()

func save_stats():
	var config = ConfigFile.new()
	
	# Save stats under the character's name section
	for stat_name in stats:
		config.set_value(selected_character, stat_name, stats[stat_name])
	
	# Save the file
	var error = config.save("user://character_stats.save")
	if error != OK:
		print("Error saving stats: ", error)
		return false
	print("Stats Saved for ", selected_character, ": ", stats)
	return true

func load_stats():
	var config = ConfigFile.new()
	
	# Check if the save file exists
	if not FileAccess.file_exists("user://character_stats.save"):
		print("Save file not found - Using base stats")
		return false
	
	# Load the file
	var error = config.load("user://character_stats.save")
	if error != OK:
		print("Error loading stats: ", error)
		return false
	
	# Load stats from the character's section
	for stat_name in stats:
		if config.has_section_key(selected_character, stat_name):
			stats[stat_name] = config.get_value(selected_character, stat_name)
	
	print("Stats Loaded for ", selected_character, ": ", stats)
	return true

func update_stat(stat_name: String, value: int):
	if stats.has(stat_name):
		stats[stat_name] = value
		print("Stat Updated for ", selected_character, " - ", stat_name, " is now: ", value)
		return true
	return false
