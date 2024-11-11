extends Timer

@onready var movement_component : Node = $"../Movement Component"

# Called when the node enters the scene tree for the first time.
func _ready():
	print('dash start')

func _on_timeout():
	movement_component.speed = 250.0
	movement_component.current_acceleration = movement_component.base_acceleration
	print('dash stop')
