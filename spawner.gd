extends Node2D

@onready var timer : Timer = $Timer

@export var spawn_scene : PackedScene
@export var target_scene : PackedScene
@export var spawn_interval : float = 2.0
@export var spawn_radius : float = 1000.0

var player : Node2D

func _ready():
	print("Spawner Started")
	if timer:
		timer.start()
	
	# Set the player reference when the scene starts
	set_player_reference()

func set_player_reference():
	if target_scene:
		var target_instance = target_scene.instantiate()
		if target_instance is Node2D:
			player = target_instance
			# Don't forget to add the player to the scene if it's not already there
			if not player.is_inside_tree():
				add_child(player)
			# Move the player to the top of the node hierarchy
			move_child(player, 0)
		else:
			print("Target scene is not a Node2D")
	else:
		print("No target scene set")

func _on_timer_timeout():
	if spawn_scene:
		var instance = spawn_scene.instantiate()
		
		# Pass the player reference to the spawned instance if it has a 'player' property
		if instance.has_method("set_player"):
			instance.set_player(player)
		elif instance.has_property("player"):
			instance.player = player
		
		var spawn_position = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
		instance.position = spawn_position
		add_child(instance)
	else:
		print("No Scene to Spawn")
