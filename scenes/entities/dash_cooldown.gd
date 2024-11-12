extends Timer

@onready var movement_component : Node = $"../Movement Component"

func _on_timeout():
	movement_component.is_dashing = false
