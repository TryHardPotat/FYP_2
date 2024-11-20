extends Area2D

@export var base_damage = 5
var damage: float:
	get:
		return SaveManager.stats.damage * Global.subclass_damage_multiplier

func _ready():
	base_damage = SaveManager.stats.damage  # Initialize base_damage with saved value

func _process(_delta):
	look_at(get_global_mouse_position())

func _on_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != get_parent().team:
		body.take_damage(damage)
