extends Area2D

@export var damage = 5

func _process(_delta):
	look_at(get_global_mouse_position())

func _on_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != get_parent().team:
		body.take_damage(damage)
