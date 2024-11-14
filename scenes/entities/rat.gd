extends CharacterBody2D

@export var speed = 100
@export var player : Node2D
@export var health : float = 10
@export var damage : float = 5
@export var team : String = "enemy"

@onready var health_bar = $CanvasGroup/HealthBar
@onready var base_health = health
@onready var base_damage = damage
@onready var base_speed = speed

func _ready():
	var scaler = get_node("/root/ActiveScene/DifficultyScaler")
	if scaler:
		health = base_health * scaler.get_health_multiplier()
		damage = base_damage * scaler.get_damage_multiplier()
		speed = base_speed * scaler.get_speed_multiplier()
		
		# Set the health bar's max value to match the scaled health
		health_bar.max_value = health
		health_bar.value = health

func set_player(new_player):
	player = new_player

func take_damage(amount):
	health -= amount
	update_health()
	if health <= 0:
		die()

func update_health():
	health_bar.value = health

func despawn():
	print('rat despawned - outside playarea')
	queue_free()

func die():
	Global.current_run_gold += 1
	if player:
		var exp_amount = 1
		player.gain_exp(exp_amount)
	queue_free()  # Remove the enemy from the scene

func _physics_process(_delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_hitbox_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != team:
		body.take_damage(damage)
