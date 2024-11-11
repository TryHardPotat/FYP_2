extends Control

func _on_select_athlete_pressed():
	print('Subclass: Athlete Selected')
	start_game()

func _on_select_tank_pressed():
	print('Subclass: Tank Selected')
	start_game()

func _on_select_glasscannon_pressed():
	print('Subclass: Glass Cannon Selected')
	start_game()

func start_game():
	get_tree().change_scene_to_file("res://active_scene.tscn")
