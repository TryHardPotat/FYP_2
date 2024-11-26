extends Control

func _on_play_pressed():
	print('play button pressed')
	get_tree().change_scene_to_file("res://scenes/menus/character_select.tscn")

func _on_tutorial_pressed():
	print('tutorial button pressed')
	get_tree().change_scene_to_file("res://scenes/menus/tutorial.tscn")

func _on_credits_pressed():
	print('credits button pressed')

func _on_quit_pressed():
	print('quit button pressed')
	get_tree().quit()
