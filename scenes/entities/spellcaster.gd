extends CharacterBody2D

@onready var movement_component : Movement_Component = $"Movement Component"
@onready var attack_component : Ranged_Attack_Component = $"Ranged Attack Component"
@onready var hurtbox : Area2D = $Hurtbox
@onready var exp_bar : ProgressBar = $CanvasGroup/ExperienceBar
@onready var level_up_audio_player : AudioStreamPlayer2D = $LevelUpAudio

var team : String = "player"
var player_exp = Global.player_exp
var player_level = Global.player_level
var base_damage = 10

func _ready():
	base_damage = SaveManager.stats.damage

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
	
	## Sound Effect
	level_up_audio_player.stream = load("res://assets/audio/level-up-3-199576.mp3")
	level_up_audio_player.play()
	
	## Increase Player Attributes
	# Damage
	base_damage *= 1.1
	
	# Health
	var old_health_percent = $Hurtbox.health / $Hurtbox.max_health
	$Hurtbox.max_health *= 1.1
	$Hurtbox.health = $Hurtbox.max_health * old_health_percent
	$Hurtbox.update_health_bar()
	
	print("Level Up: Player Level ", player_level)
