extends CharacterBody2D

@export var speed = 100
@export var player: Node2D
@export var health : float = 10

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()  # Remove the enemy from the scene

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		
		move_and_slide()
