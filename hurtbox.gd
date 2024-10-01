extends Area2D

@onready var health_bar = $"../CanvasGroup/HealthBar"

@export var health = 10

func take_damage(amount):
	health -= amount
	update_health()
	if health <= 0:
		print("Character Died")
		get_tree().paused = true

func update_health():
	health_bar.value = health
