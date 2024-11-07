extends CharacterBody2D

@onready var movement_component : Movement_Component = $Movement_Component
@onready var attack_component : Ranged_Attack_Component = $"Ranged Attack Component"
@onready var hurtbox : Area2D = $Hurtbox

var team : String = "player"

func _physics_process(_delta):
	var input_velocity = movement_component.velocity
	var acceleration = movement_component.current_acceleration
	velocity = velocity.lerp(input_velocity, acceleration)
	move_and_slide()

func take_damage(amount):
	hurtbox.take_damage(amount)
