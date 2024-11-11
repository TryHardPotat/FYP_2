extends Timer

@onready var movement_component : Node = $"../Movement Component"

func _ready():
	print('dash cooldown started')

func _on_timeout():
	movement_component.is_dashing = false
	print('dash cooldown ended')
