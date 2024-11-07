extends CharacterBody2D

@onready var movement_component : Movement_Component = $"Movement Component"
@onready var attack_component : Melee_Attack_Component = $"Melee Attack Component"
@onready var hurtbox : Area2D = $Hurtbox

var team : String = "player"

func _physics_process(_delta):
	var input_velocity = movement_component.velocity
	var acceleration = movement_component.current_acceleration
	velocity = velocity.lerp(input_velocity, acceleration)
	move_and_slide()

func take_damage(amount):
	hurtbox.take_damage(amount)
