extends Area2D

@export var damage = 5
@export var speed = 750

var team : String = "player"
var direction = Vector2.RIGHT  # Will be set by ranged_attack_component

func _ready():
	# Rotate the pebble sprite/node to match the shooting direction
	rotation = direction.angle()
	
	# Create and start lifetime timer
	var lifetime = Timer.new()
	lifetime.wait_time = 2.0
	lifetime.one_shot = true
	add_child(lifetime)
	lifetime.timeout.connect(_on_lifetime_timeout)
	lifetime.start()
	
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	position += direction * speed * delta

func _on_lifetime_timeout():
	queue_free()
	print("projectile death")

func _on_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != team:
		body.take_damage(damage)
		queue_free()
