extends Node

var room_tiles = 32
var pixel = 32
@export var room_scenes : Array[PackedScene] # Holds room types
@export var dungeon_width : int = Global.dungeon_width
@export var dungeon_height : int = Global.dungeon_height
@export var room_size : Vector2 = Vector2(room_tiles * pixel, room_tiles * pixel)
var rooms = []

func place_room(x : int, y : int) -> Node2D:
	# Randomly select a room scene
	var random_room_scene = room_scenes[randi() % room_scenes.size()]
	var room_instance = random_room_scene.instantiate()
	room_instance.transform.origin = Vector2(x * room_size.x, y * room_size.y)
	room_instance.z_index = -1  # Set z_index to -1 to ensure it's behind other elements
	add_child(room_instance)
	return room_instance

func get_dungeon_center() -> Vector2:
	var dungeon_total_width = dungeon_width * room_size.x
	var dungeon_total_height = dungeon_height * room_size.y
	
	var center = Vector2(
		dungeon_total_width / 2,
		dungeon_total_height / 2
	)
	
	return center

func generate_dungeon():
	rooms = []
	for x in range(dungeon_width):
		var column = []
		for y in range(dungeon_height):
			var room = place_room(x, y)
			column.append(room)
		rooms.append(column)

func _ready():
	if room_scenes.is_empty():
		push_error("No room scenes assigned to the dungeon generator!")
		return
	generate_dungeon()
