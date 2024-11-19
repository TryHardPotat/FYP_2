extends Control

func _ready():
	# Ensure a character is selected and initialized
	if SaveManager.selected_character == "":
		print("No character selected")
		get_tree().change_scene_to_file("res://scenes/menus/character_select.tscn")
		return
		
	# Check if stats are initialized
	if SaveManager.stats.is_empty():
		print("Stats not initialized")
		SaveManager.select_character(SaveManager.selected_character)
		
	update_ui()
	
func update_ui():
	var stats = SaveManager.stats
	if stats.is_empty():
		print("Error: Stats are empty")
		return
		
	print("Updating UI with stats: ", stats) # Debug print
	
	# Update character name
	$CenterContainer/VBoxContainer/CharacterNameLabel.text = SaveManager.selected_character
	
	# Update levels
	$CenterContainer/VBoxContainer/HBoxContainer/HealthContainer/VBoxContainer/Level.text = "Level: " + str(stats.get("health_level", 0))
	$CenterContainer/VBoxContainer/HBoxContainer/DamageContainer/VBoxContainer/Level.text = "Level: " + str(stats.get("damage_level", 0))
	$CenterContainer/VBoxContainer/HBoxContainer/SpeedContainer/VBoxContainer/Level.text = "Level: " + str(stats.get("speed_level", 0))
	
	# Update current values
	$CenterContainer/VBoxContainer/HBoxContainer/HealthContainer/VBoxContainer/Value.text = str(stats.get("health", 0))
	$CenterContainer/VBoxContainer/HBoxContainer/DamageContainer/VBoxContainer/Value.text = str(stats.get("damage", 0))
	$CenterContainer/VBoxContainer/HBoxContainer/SpeedContainer/VBoxContainer/Value.text = str(stats.get("speed", 0))
	
	# Update costs
	$CenterContainer/VBoxContainer/HBoxContainer/HealthContainer/VBoxContainer/Cost.text = str(stats.get("health_cost", 50)) + " Gold"
	$CenterContainer/VBoxContainer/HBoxContainer/DamageContainer/VBoxContainer/Cost.text = str(stats.get("damage_cost", 50)) + " Gold"
	$CenterContainer/VBoxContainer/HBoxContainer/SpeedContainer/VBoxContainer/Cost.text = str(stats.get("speed_cost", 50)) + " Gold"
	
	# Update gold
	$CenterContainer/VBoxContainer/PanelContainer/GoldContainer/HBoxContainer/GoldValue.text = str(stats.get("gold", 0))
	
	# Update button states based on affordability
	update_button_states()

func update_button_states():
	var stats = SaveManager.stats
	if stats.is_empty():
		return
		
	# Update button disabled states directly
	$CenterContainer/VBoxContainer/HBoxContainer/HealthContainer/VBoxContainer/UpgradeButton.disabled = not SaveManager.can_afford_upgrade(stats.get("health_cost", 50))
	$CenterContainer/VBoxContainer/HBoxContainer/DamageContainer/VBoxContainer/UpgradeButton.disabled = not SaveManager.can_afford_upgrade(stats.get("damage_cost", 50))
	$CenterContainer/VBoxContainer/HBoxContainer/SpeedContainer/VBoxContainer/UpgradeButton.disabled = not SaveManager.can_afford_upgrade(stats.get("speed_cost", 50))

func _on_health_upgrade_pressed():
	print("Health upgrade button pressed")
	print("Current stats before upgrade: ", SaveManager.stats)
	if SaveManager.attempt_upgrade("health"):
		print("Health upgrade successful")
		update_ui()
	else:
		print("Health upgrade failed")
		print("Gold: ", SaveManager.stats.gold)
		print("Cost: ", SaveManager.stats.get("health_cost", 50))

func _on_damage_upgrade_pressed():
	print("Damage upgrade button pressed")
	print("Current stats before upgrade: ", SaveManager.stats)
	if SaveManager.attempt_upgrade("damage"):
		print("Damage upgrade successful")
		update_ui()
	else:
		print("Damage upgrade failed")
		print("Gold: ", SaveManager.stats.gold)
		print("Cost: ", SaveManager.stats.get("damage_cost", 50))

func _on_speed_upgrade_pressed():
	print("Speed upgrade button pressed")
	print("Current stats before upgrade: ", SaveManager.stats)
	if SaveManager.attempt_upgrade("speed"):
		print("Speed upgrade successful")
		update_ui()
	else:
		print("Speed upgrade failed")
		print("Gold: ", SaveManager.stats.gold)
		print("Cost: ", SaveManager.stats.get("speed_cost", 50))

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/character_select.tscn")

# Optional: Add gold for testing
func _on_add_gold_pressed():
	SaveManager.stats.gold += 100
	SaveManager.save_stats()
	update_ui()
