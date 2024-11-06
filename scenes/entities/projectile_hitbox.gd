extends Area2D

var damage : int = 2

func _on_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != get_parent().team:
		body.take_damage(damage)
