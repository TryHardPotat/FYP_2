extends Node
class_name Ranged_Attack_Component

@onready var attack_cooldown = $"../Ranged Attack Cooldown"
@onready var projectile_container = get_tree().get_root().get_node("ActiveScene/Projectiles")
@onready var projectile_guide = $"../Projectile Guide"
@export var projectile: PackedScene
@export var cooldown_time: float = 1.0
@export var projectile_lifetime: float = 2.0

var is_attacking = false

func _process(_delta):
	input_attack()

func input_attack():
	if Input.is_action_pressed("primary_attack"):
		attack()

func attack():
	if is_attacking:
		return
		
	if projectile == null:
		print("Error: Pebble scene not assigned!")
		return
		
	if projectile_container == null:
		print("Error: Projectile container not found!")
		return
	
	var instance = projectile.instantiate()
	instance.global_position = $"..".global_position
	instance.direction = Vector2.RIGHT.rotated(projectile_guide.rotation)
	projectile_container.add_child(instance)
	is_attacking = true
	attack_cooldown.start()
	print("pebble shot")
