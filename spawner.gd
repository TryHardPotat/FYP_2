extends Node2D

@onready var timer : Timer = $Timer

@export var spawn_scene : PackedScene
@export var spawn_interval : float = 2.0
@export var spawn_radius : float = 1000.0

func _ready():
	print("Spawner Started")
	if timer:
		timer.start()

func _on_timer_timeout():
	if spawn_scene:
		var instance = spawn_scene.instantiate()
		var spawn_position = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
		
		instance.position = spawn_position
		add_child(instance)
	else:
		print("No Scene to Spawn")
