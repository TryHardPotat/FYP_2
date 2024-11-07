extends Timer

@onready var attack_component = $"../Melee Attack Component"

func _ready():
	print("attack cooldown started")

func _on_timeout():
	attack_component.is_attacking = false
	print("attack cooldown ended")
