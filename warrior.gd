extends CharacterBody2D

@onready var movement_component : MovementComponent = $Movement_Component

func _physics_process(delta):
	var input_velocity = movement_component.velocity
	velocity = input_velocity
	move_and_slide()
