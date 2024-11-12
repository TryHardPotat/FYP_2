extends Control

func _on_select_athlete_pressed():
	Global.apply_subclass_multiplier("Athlete")
	print('Subclass: Athlete Selected')
	start_game()

func _on_select_tank_pressed():
	Global.apply_subclass_multiplier("Tank")
	print('Subclass: Tank Selected')
	start_game()

func _on_select_glasscannon_pressed():
	Global.apply_subclass_multiplier("GlassCannon")
	print('Subclass: Glass Cannon Selected')
	start_game()

func start_game():
	get_tree().change_scene_to_file("res://active_scene.tscn")
