extends Timer

@onready var hitbox = $"../Hitbox"

func _on_timeout():
	hitbox.monitoring = false
