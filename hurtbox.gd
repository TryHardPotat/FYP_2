extends Area2D

@onready var health_bar = $"../CanvasGroup/HealthBar"

var health : int = SaveManager.stats["health"]

func _ready():
	$"../CanvasGroup/HealthBar".max_value = health
	$"../CanvasGroup/HealthBar".value = health

func take_damage(amount):
	health -= amount
	# Update both local health display and saved stats
	SaveManager.update_stat("health", health)
	update_health()
	
	if health <= 0:
		print("Character Died")
		get_tree().paused = true

func update_health():
	health_bar.value = health
