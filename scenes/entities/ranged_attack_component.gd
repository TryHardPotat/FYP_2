extends Node
class_name Ranged_Attack_Component

@onready var attack_cooldown = $"../Ranged Attack Cooldown"
@onready var projectile_container = get_tree().get_root().get_node("ActiveScene/Projectiles")
@onready var projectile_guide = $"../ProjectileGuide"  # Reference to your guide node
@export var pebble: PackedScene
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
		
	if pebble == null:
		print("Error: Pebble scene not assigned!")
		return
		
	if projectile_container == null:
		print("Error: Projectile container not found!")
		return
	
	var instance = pebble.instantiate()
	# Set the position to spawn from the character
	instance.global_position = $"..".global_position
	# Get the direction from the projectile guide's rotation
	instance.direction = Vector2.RIGHT.rotated(projectile_guide.rotation)
	projectile_container.add_child(instance)
	is_attacking = true
	attack_cooldown.start()
	print("pebble shot")
