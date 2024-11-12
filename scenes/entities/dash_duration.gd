extends Timer

@onready var movement_component : Node = $"../Movement Component"

func _on_timeout():
	movement_component.speed = 250.0
	movement_component.current_acceleration = movement_component.base_acceleration
