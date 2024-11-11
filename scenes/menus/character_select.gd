extends Control

## TODO: Upgrades Screen

func _on_select_scout_pressed():
	Global.selected_character = Global.character_scenes["Scout"]
	SaveManager.select_character("Scout")
	print('Class: Scout Selected')
	start_game()

func _on_upgrade_scout_pressed():
	print('Upgrade Screen: Scout Selected')

func _on_select_slingshot_pressed():
	Global.selected_character = Global.character_scenes["Slingshot"]
	SaveManager.select_character("Slingshot")
	print('Class: Slingshot Selected')
	start_game()

func _on_upgrade_slingshot_pressed():
	print('Upgrade Screen: Slingshot Selected')

func _on_select_spellcaster_pressed():
	Global.selected_character = Global.character_scenes["Spellcaster"]
	SaveManager.select_character("Spellcaster")
	print('Class: Spellcaster Selected')
	start_game()

func _on_upgrade_spellcaster_pressed():
	print('Upgrade Screen: Spellcaster Selected')

func start_game():
	get_tree().change_scene_to_file("res://scenes/menus/subclass_select.tscn")
