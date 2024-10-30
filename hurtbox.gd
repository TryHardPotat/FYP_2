extends Area2D

@onready var health_bar = $"../CanvasGroup/HealthBar"

var health : int = SaveManager.stats["health"]

func _ready():
	$"../CanvasGroup/HealthBar".max_value = health
	$"../CanvasGroup/HealthBar".value = health

func take_damage(amount):
	health -= amount
	update_health()
	
	if health <= 0:
		print("Character Died")
		get_tree().paused = true
		get_tree().change_scene_to_file("res://scenes/menus/game_over_screen.tscn")

func update_health():
	health_bar.value = health
