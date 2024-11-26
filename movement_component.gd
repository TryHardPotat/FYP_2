extends Node
class_name Movement_Component

@onready var dash_duration : Timer = $"../Dash Duration"
@onready var dash_cooldown : Timer = $"../Dash Cooldown"
@onready var sprite = $"../Sprite"

@export var base_acceleration = 0.1 # Ranges from 0 - 1
var speed = SaveManager.stats.speed * Global.subclass_speed_multiplier
var current_acceleration = base_acceleration

var input_direction = Vector2.ZERO
var velocity = Vector2.ZERO
var is_dashing : bool = false

func _process(delta):
	input_handler()
	movement_handler(delta)
	update_animation()
	input_dash()

func input_handler():
	input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("move_left", "move_right")
	input_direction.y = Input.get_axis("move_up", "move_down")
	input_direction = input_direction.normalized()

func update_animation():
	# Check if the player is moving or idle
	if velocity.length() > 0:
		sprite.play("walk")
	else:
		sprite.play("idle")

func movement_handler(_delta):
	velocity = input_direction * speed

func input_dash():
	if Input.is_action_pressed("dash"):
		dash()

func dash():
	if is_dashing:
		pass
	else:
		is_dashing = true
		speed *= 2
		current_acceleration = 1
		dash_duration.start()
		dash_cooldown.start()
