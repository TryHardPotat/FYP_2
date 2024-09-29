extends CharacterBody2D

@onready var movement_component : MovementComponent = $MovementComponent

func _physics_process(delta):
	var input_velocity = movement_component.velocity
	var acceleration = movement_component.acceleration
	velocity = velocity.lerp(input_velocity, acceleration)
	move_and_slide()
