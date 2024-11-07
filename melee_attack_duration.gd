extends Timer

@onready var hitbox = $"../Hitbox"

func _ready():
	print("attack duration started")

func _on_timeout():
	hitbox.monitoring = false
	print("attack duration ended")
