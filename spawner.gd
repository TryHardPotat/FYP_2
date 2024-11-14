extends Node2D

@onready var timer : Timer = $Timer
@onready var enemy_container = get_tree().get_root().get_node("ActiveScene/Enemies")
@export var spawn_scene : PackedScene ## Enemy Scene
@export var target_scene : PackedScene = Global.selected_character ## Player Scene
@export var spawn_interval : float = 2.0
@export var spawn_radius : float = 800.0
var player : Node2D

func _ready():
	print("Spawner Started")
	if timer:
		timer.start()
	
	set_player_reference()

func set_player_reference():
	if target_scene:
		var target_instance = target_scene.instantiate()
		target_instance.position = $"../DungeonGenerator".get_dungeon_center()
		if target_instance is Node2D:
			player = target_instance
			if not player.is_inside_tree():
				add_child(player)
		else:
			print("Target scene is not a Node2D")
	else:
		print("No target scene set")

func _on_timer_timeout():
	if spawn_scene and player and enemy_container:
		var instance = spawn_scene.instantiate()
		
		if instance.has_method("set_player"):
			instance.set_player(player)
		elif instance.has_property("player"):
			instance.player = player
		
		# Generate a random angle
		var angle = randf() * TAU  # TAU is 2*PI, giving us a full circle
		
		# Generate a random distance between min and max spawn radius
		var min_spawn_radius = spawn_radius * 0.5  # You can adjust this multiplier
		var spawn_distance = randf_range(min_spawn_radius, spawn_radius)
		
		# Calculate spawn position relative to player
		var spawn_offset = Vector2(
			cos(angle) * spawn_distance,
			sin(angle) * spawn_distance
		)
		
		# Set final position relative to player's position
		instance.position = player.position + spawn_offset
		
		enemy_container.add_child(instance)
	else:
		print("No Scene to Spawn")

func update_target_scene(new_scene: PackedScene):
	target_scene = new_scene
	set_player_reference()
