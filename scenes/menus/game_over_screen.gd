extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://active_scene.tscn")

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
