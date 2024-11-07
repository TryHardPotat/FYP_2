extends Timer

@onready var attack_component = $"../Ranged Attack Component"

func _ready():
	one_shot = true
	wait_time = attack_component.cooldown_time
	print("attack cooldown started")

func _on_timeout():
	attack_component.is_attacking = false
	print("attack cooldown ended")
