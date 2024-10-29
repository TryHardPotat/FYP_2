extends Control

## TODO: Upgrades Screen

func _on_select_scout_pressed():
	Global.selected_character = Global.character_scenes["Scout"]
	SaveManager.select_character("Scout")
	start_game()

func _on_upgrade_scout_pressed():
	pass # Replace with function body.

func _on_select_slingshot_pressed():
	Global.selected_character = Global.character_scenes["Slingshot"]
	SaveManager.select_character("Slingshot")
	start_game()

func _on_upgrade_slingshot_pressed():
	pass # Replace with function body.

func _on_select_spellcaster_pressed():
	Global.selected_character = Global.character_scenes["Spellcaster"]
	SaveManager.select_character("Spellcaster")
	start_game()

func _on_upgrade_spellcaster_pressed():
	pass # Replace with function body.

func start_game():
	get_tree().change_scene_to_file("res://active_scene.tscn")
