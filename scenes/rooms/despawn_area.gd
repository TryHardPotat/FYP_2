extends Node2D

func _on_despawn_area_body_entered(body):
	if body.has_method("despawn"):
		body.despawn()
