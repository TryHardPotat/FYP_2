extends Node
class_name Movement_Component

@onready var dash_timer : Timer = $"../Dash Timer"

@export var speed = 250.0
@export var base_acceleration = 0.1 # Ranges from 0 - 1
var current_acceleration = base_acceleration

var input_direction = Vector2.ZERO
var velocity = Vector2.ZERO
var dashing : bool = false

func _process(delta):
	input_handler()
	movement_handler(delta)
	input_dash()

func input_handler():
	input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("move_left", "move_right")
	input_direction.y = Input.get_axis("move_up", "move_down")
	input_direction = input_direction.normalized()

func movement_handler(_delta):
	velocity = input_direction * speed

## TODO: Implement dash cooldown.
func input_dash():
	if Input.is_action_just_pressed("dash"):
		dashing = true
		speed = 500
		current_acceleration = 1
		dash_timer.start()

func _on_dash_timer_timeout():
	dashing = false
	speed = 250
	current_acceleration = base_acceleration
