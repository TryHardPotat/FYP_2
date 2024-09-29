extends Node
class_name MovementComponent

@export var speed = 500.0

var input_direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _process(delta):
	input_handler()
	movement_handler(delta)

func input_handler():
	input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("move_left", "move_right")
	input_direction.y = Input.get_axis("move_up", "move_down")
	input_direction = input_direction.normalized()

func movement_handler(delta):
	velocity = input_direction * speed
