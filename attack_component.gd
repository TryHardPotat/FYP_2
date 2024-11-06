extends Node
class_name AttackComponent

@onready var hitbox = $"../Hitbox"
@onready var attack_timer = $"../AttackTimer"
@onready var projectile_guide = $"../ProjectileGuide"
@onready var projectile_container = get_tree().get_root().get_node("ActiveScene/Projectiles")
@export var damage = 5
@export var pebble_scene: PackedScene
var is_attacking = false

func input_attack():
	if Input.is_action_just_pressed("primary_attack"):  # Changed to just_pressed to fire one at a time
		attack()

func attack():
	var pebble = pebble_scene.instantiate()
	pebble.spawnPos = projectile_guide.global_position
	pebble.dir = projectile_guide.rotation
	projectile_container.add_child(pebble)

func _process(delta):
	input_attack()
