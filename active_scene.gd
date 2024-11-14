extends Node2D

func _ready():
	Global.current_run_gold = 0
	Global.player_exp = 1
	Global.player_exp = 0
	Global.gold = SaveManager.stats["gold"]
	
	# Optional: Connect to difficulty signal for UI updates
	var scaler = $DifficultyScaler
	if scaler:
		scaler.difficulty_increased.connect(_on_difficulty_increased)

func _on_difficulty_increased(interval: int, health: float, damage: float, speed: float):
	print("Difficulty increased! Interval: %d" % interval)
	# Update UI or other game systems here
