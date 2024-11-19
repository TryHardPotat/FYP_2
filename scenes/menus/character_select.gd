extends Control

## TODO: Upgrades Screen

func _on_select_scout_pressed():
	Global.selected_character = Global.character_scenes["Scout"]
	SaveManager.select_character("Scout")
	print('Class: Scout Selected')
	subclass_select()

func _on_upgrade_scout_pressed():
	Global.selected_character = Global.character_scenes["Scout"]
	SaveManager.select_character("Scout")
	print('Upgrade Screen: Scout Selected')
	upgrade_menu()

func _on_select_slingshot_pressed():
	Global.selected_character = Global.character_scenes["Slingshot"]
	SaveManager.select_character("Slingshot")
	print('Class: Slingshot Selected')
	subclass_select()

func _on_upgrade_slingshot_pressed():
	Global.selected_character = Global.character_scenes["Slingshot"]
	SaveManager.select_character("Slingshot")
	print('Upgrade Screen: Slingshot Selected')
	upgrade_menu()

func _on_select_spellcaster_pressed():
	Global.selected_character = Global.character_scenes["Spellcaster"]
	SaveManager.select_character("Spellcaster")
	print('Class: Spellcaster Selected')
	subclass_select()

func _on_upgrade_spellcaster_pressed():
	Global.selected_character = Global.character_scenes["Spellcaster"]
	SaveManager.select_character("Spellcaster")
	print('Upgrade Screen: Spellcaster Selected')
	upgrade_menu()

func subclass_select():
	get_tree().change_scene_to_file("res://scenes/menus/subclass_select.tscn")

func upgrade_menu():
	get_tree().change_scene_to_file("res://scenes/menus/upgrade_screen.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
