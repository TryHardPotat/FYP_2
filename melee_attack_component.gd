extends Node
class_name Melee_Attack_Component

@onready var hitbox = $"../Hitbox"
@onready var attack_duration = $"../Melee Attack Duration"
@onready var attack_cooldown = $"../Melee Attack Cooldown"
@onready var attack_audio_player = $"../AttackAudio"

var is_attacking = false

func input_attack():
	if Input.is_action_pressed("primary_attack"):
		attack()

func attack():
	if is_attacking:
		pass
	else:
		hitbox.monitoring = true
		is_attacking = true
		attack_duration.start()
		attack_cooldown.start()
		
		## Sound Effectw
		attack_audio_player.stream = load("res://assets/audio/scout_attack.mp3")
		attack_audio_player.play()

func _process(_delta):
	input_attack()
