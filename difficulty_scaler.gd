extends Node

# Base scaling configuration
var base_health_multiplier : float = 1.0
var base_damage_multiplier : float = 1.0
var base_speed_multiplier : float = 1.0

# Scaling intervals
@export var scaling_interval : float = 30.0  # Seconds between difficulty increases
@export var scaling_factor : float = 0.1     # How much to increase multipliers each interval

# Time tracking
var elapsed_time : float = 0.0
var current_interval : int = 0

# Signals
signal difficulty_increased(interval: int, health_multi: float, damage_multi: float, speed_multi: float)

func _ready():
	# Add to autoload singleton if needed
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	elapsed_time += delta
	
	# Check if we should increase difficulty
	var new_interval = int(elapsed_time / scaling_interval)
	if new_interval > current_interval:
		current_interval = new_interval
		increase_difficulty()

func increase_difficulty():
	# Increase all multipliers by scaling factor
	base_health_multiplier += scaling_factor
	base_damage_multiplier += scaling_factor
	base_speed_multiplier += scaling_factor
	
	# Emit signal for UI updates or other systems
	difficulty_increased.emit(
		current_interval,
		base_health_multiplier,
		base_damage_multiplier,
		base_speed_multiplier
	)

# Get current multipliers
func get_health_multiplier() -> float:
	return base_health_multiplier

func get_damage_multiplier() -> float:
	return base_damage_multiplier

func get_speed_multiplier() -> float:
	return base_speed_multiplier

# Reset difficulty
func reset_difficulty():
	elapsed_time = 0.0
	current_interval = 0
	base_health_multiplier = 1.0
	base_damage_multiplier = 1.0
	base_speed_multiplier = 1.0
