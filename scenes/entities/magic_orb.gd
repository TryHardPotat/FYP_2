extends Area2D

@onready var projectile_audio_player : AudioStreamPlayer2D = $ProjectileSFX

var damage = 0
@export var speed = 250

var team : String = "player"
var direction = Vector2.RIGHT

func initialize(base_damage: float):
	damage = base_damage * Global.subclass_damage_multiplier

func _ready():
	rotation = direction.angle()
	
	var lifetime = Timer.new()
	lifetime.wait_time = 2.0
	lifetime.one_shot = true
	add_child(lifetime)
	lifetime.timeout.connect(_on_lifetime_timeout)
	lifetime.start()
	
	projectile_audio_player.stream = load("res://assets/audio/spellcaster_attack.mp3")
	projectile_audio_player.play()
	
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	position += direction * speed * delta

func _on_lifetime_timeout():
	queue_free()
	print("projectile death")

func _on_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != team:
		body.take_damage(damage)
