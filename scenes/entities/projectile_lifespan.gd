extends Timer

func _ready():
	print("projectile life")

func _on_timeout():
	queue_free()
	print("projectile death")
