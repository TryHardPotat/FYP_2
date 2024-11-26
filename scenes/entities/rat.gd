extends CharacterBody2D

@export var speed = 100
@export var player : Node2D
@export var health : float = 10
@export var damage : float = 5
@export var team : String = "enemy"
@export var avoidance_radius : float = 50.0  # Radius to check for other enemies
@export var wall_avoidance_distance : float = 30.0  # Distance to check for walls

@onready var health_bar = $CanvasGroup/HealthBar
@onready var base_health = health
@onready var base_damage = damage
@onready var base_speed = speed

func _ready():
	var scaler = get_node("/root/ActiveScene/DifficultyScaler")
	if scaler:
		health = base_health * scaler.get_health_multiplier()
		damage = base_damage * scaler.get_damage_multiplier()
		speed = base_speed * scaler.get_speed_multiplier()
		
		health_bar.max_value = health
		health_bar.value = health

func set_player(new_player):
	player = new_player

func take_damage(amount):
	health -= amount
	update_health()
	if health <= 0:
		die()

func update_health():
	health_bar.value = health

func despawn():
	print('rat despawned - outside playarea')
	queue_free()
	

func die():
	Global.current_run_gold += 1
	if player:
		var exp_amount = 1
		player.gain_exp(exp_amount)
	queue_free()

func get_avoidance_vector():
	var avoidance = Vector2.ZERO
	
	# Avoid other enemies
	for entity in get_tree().get_nodes_in_group("enemies"):
		if entity != self:
			var distance = global_position.distance_to(entity.global_position)
			if distance < avoidance_radius:
				var avoid_direction = global_position - entity.global_position
				avoidance += avoid_direction.normalized() * (avoidance_radius - distance) / avoidance_radius
	
	# Wall avoidance using raycasts
	var directions = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN, 
					 Vector2(1, 1).normalized(), Vector2(-1, 1).normalized(),
					 Vector2(1, -1).normalized(), Vector2(-1, -1).normalized()]
	
	var space_state = get_world_2d().direct_space_state
	for direction in directions:
		var query = PhysicsRayQueryParameters2D.create(global_position, 
													 global_position + direction * wall_avoidance_distance)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		
		if result:
			var wall_normal = result.normal
			var distance_to_wall = global_position.distance_to(result.position)
			avoidance += wall_normal * (wall_avoidance_distance - distance_to_wall) / wall_avoidance_distance
	
	return avoidance.normalized()

func _physics_process(_delta):
	if player:
		# Get direction to player
		var direction = (player.global_position - global_position).normalized()
		
		# Get avoidance vector
		var avoidance = get_avoidance_vector()
		
		# Combine vectors with weights
		var final_direction = direction + avoidance * 0.5
		final_direction = final_direction.normalized()
		
		# Apply movement
		velocity = final_direction * speed
		move_and_slide()

func _on_hitbox_body_entered(body):
	if body.has_method("take_damage") and body.get("team") != team:
		body.take_damage(damage)
