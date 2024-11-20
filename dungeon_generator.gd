extends Node

var room_tiles = 32
var pixel = 32
@export var room_scenes : Array[PackedScene] # Holds room types
@export var center_room_scene : PackedScene # Specific room for center
@export var dungeon_width : int = Global.dungeon_width
@export var dungeon_height : int = Global.dungeon_height
@export var room_size : Vector2 = Vector2(room_tiles * pixel, room_tiles * pixel)
var rooms = []

func place_room(x : int, y : int, room_scene : PackedScene) -> Node2D:
	var room_instance = room_scene.instantiate()
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
	var center_x = int(dungeon_width / 2)
	var center_y = int(dungeon_height / 2)

	for x in range(dungeon_width):
		var column = []
		for y in range(dungeon_height):
			var room  # Declare room variable here
			
			# Place center room at the center position
			if x == center_x and y == center_y:
				room = place_room(x, y, center_room_scene)
			else:
				# Randomly select a room scene for other positions
				var random_room_scene = room_scenes[randi() % room_scenes.size()]
				room = place_room(x, y, random_room_scene)
			
			column.append(room)
		rooms.append(column)

func _ready():
	if room_scenes.is_empty() or center_room_scene == null:
		push_error("Room scenes or center room scene is not assigned to the dungeon generator!")
		return
	generate_dungeon()
