extends Node
class_name Melee_Attack_Component

@onready var hitbox = $"../Hitbox"
@onready var attack_cooldown = $"../Melee Attack Cooldown"
@onready var attack_audio_player = $"../AttackAudio"
@onready var sprite = $"../Sprite" # Adjust path if needed
@onready var vfx = $"../Hitbox/AnimatedSprite2D"

var is_attacking = false

func _ready():
	# Connect animation_finished signals to handle end of animations using Callable
	sprite.connect("animation_finished", Callable(self, "_on_attack_animation_finished"))
	vfx.connect("animation_finished", Callable(self, "_on_vfx_animation_finished"))

func input_attack():
	if Input.is_action_just_pressed("primary_attack") and not is_attacking:
		attack()

func attack():
	# Prevent further actions if already attacking
	if is_attacking:
		return

	# Set attack state and make hitbox active
	hitbox.monitoring = true
	is_attacking = true

	# Start the cooldown timer only (no separate duration timer needed)
	attack_cooldown.start()

	# Play attack animation and VFX
	play_animation()

	# Play the attack sound effect
	attack_audio_player.stream = load("res://assets/audio/scout_attack.mp3")
	attack_audio_player.play()

func play_animation():
	# Play the attack animation
	sprite.play("attack")
	
	# Show and play the VFX
	vfx.visible = true
	vfx.play("default")

func _on_attack_animation_finished():
	# End the attack state
	hitbox.monitoring = false
	is_attacking = false  # Reset attacking state

func _on_vfx_animation_finished():
	# Hide the VFX once it’s done playing
	vfx.visible = false
	vfx.stop()

func _process(_delta):
	input_attack()
