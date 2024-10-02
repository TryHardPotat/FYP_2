extends Node

@export var is_attacking = false

func _on_attack_timer_timeout():
	is_attacking = false
