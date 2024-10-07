extends Node2D

@export var spawn_scene : PackedScene
@export var spawn_interval : float = 2.0
@export var spawn_radius : float = 100.0

func _ready():
	print("Spawner Started")
	var timer = Timer.new()
	timer.connect("timeout", Callable(self, "_on_spawn_timer,timeout"))
	timer.set_wait_time(spawn_interval)
	timer.set_one_shot(false)
	add_child(timer)
	timer.start()

func _on_spawn_timer_timeout():
	if spawn_scene:
		var instance = spawn_scene.instantiate()
		var spawn_position = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
		
		instance.position = spawn_position
		add_child(instance)
	else:
		print("No Scene to Spawn")
