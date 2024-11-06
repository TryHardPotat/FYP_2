extends CharacterBody2D

@export var speed = 100
@export var damage = 5  # Add damage value for projectiles
@export var team: String = "player"
var dir : float
var spawnPos : Vector2
var spawnRot : float

func _ready():
	global_position = spawnPos
	global_rotation = dir + PI/2
	set_collision_layer_value(2, true)  # Projectiles
	set_collision_mask_value(1, false)  # Don't collide with player
	set_collision_mask_value(3, true)   # Do collide with enemies

func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(dir + PI/2)
	
	var collision = move_and_collide(velocity * delta)
