extends CharacterBody2D

@onready var movement_component : Movement_Component = $"Movement Component"
@onready var attack_component : Ranged_Attack_Component = $"Ranged Attack Component"
@onready var hurtbox : Area2D = $Hurtbox
@onready var exp_bar : ProgressBar = $CanvasGroup/ExperienceBar

var team : String = "player"
var player_exp = Global.player_exp
var player_level = Global.player_level

func _physics_process(_delta):
	var input_velocity = movement_component.velocity
	var acceleration = movement_component.current_acceleration
	velocity = velocity.lerp(input_velocity, acceleration)
	move_and_slide()

func take_damage(amount):
	hurtbox.take_damage(amount)

func gain_exp(exp_amount):
	player_exp += exp_amount
	exp_bar.value = player_exp
	if player_exp >= exp_bar.max_value:
		level_up()
	print("Experience: ", player_exp)

func level_up():
	player_level += 1
	player_exp = 0
	exp_bar.value = 0
	exp_bar.max_value *= 1.5
	print("Level Up: Player Level ", player_level)
