extends CharacterBody2D

@export var health : float = 10

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()  # Remove the enemy from the scene
