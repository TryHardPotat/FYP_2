extends Timer

@onready var attack_component = $"../Melee Attack Component"

func _on_timeout():
	attack_component.is_attacking = false
