extends Node
class_name AttackComponent

@onready var hitbox = $"../Hitbox"
@onready var attack_timer = $"../AttackTimer"

@export var damage = 5

var is_attacking = false

## TODO: Implement attack cooldown.
func input_attack():
	if Input.is_action_pressed("primary_attack"):
		if !is_attacking:
			attack()
		elif attack_timer.is_stopped():
			attack()
	elif Input.is_action_just_released("primary_attack"):
		stop_attack()

func attack():
	if hitbox:
		hitbox.monitoring = true
	if attack_timer:
		attack_timer.start()
	is_attacking = true

func stop_attack():
	is_attacking = false
	if hitbox:
		hitbox.monitoring = false
	if attack_timer:
		attack_timer.stop()

func _process(_delta):
	input_attack()

func _on_attack_timer_timeout():
	if hitbox:
		hitbox.monitoring = false
