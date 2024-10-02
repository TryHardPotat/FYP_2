extends Node
class_name AttackComponent

@export var damage = 5
@onready var hitbox = $"../Hitbox"
@onready var attack_timer = $"../AttackTimer"

## TODO: Implement attack cooldown.
func input_attack():
	if Input.is_action_just_pressed("primary_attack"):
		attack()

func attack():
	if hitbox:
		hitbox.monitoring = true
	if attack_timer:
		attack_timer.start()

func _process(_delta):
	input_attack()

func _on_attack_timer_timeout():
	if hitbox:
		hitbox.monitoring = false
