extends Control

var spawner_scene = preload("res://spawner.tscn")
var spawner_node = spawner_scene.instantiate()

@export var scout : PackedScene
@export var slingshot : PackedScene
@export var spellcaster : PackedScene

func _on_select_scout_pressed():
	spawner_node.target_scene = scout
	start_game()

func _on_upgrade_scout_pressed():
	pass # Replace with function body.

func _on_select_slingshot_pressed():
	spawner_node.target_scene = slingshot
	start_game()

func _on_upgrade_slingshot_pressed():
	pass # Replace with function body.

func _on_select_spellcaster_pressed():
	spawner_node.target_scene = spellcaster
	start_game()

func _on_upgrade_spellcaster_pressed():
	pass # Replace with function body.

func start_game():
	get_tree().change_scene_to_file("res://active_scene.tscn")
