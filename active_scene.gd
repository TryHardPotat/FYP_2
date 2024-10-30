extends Node2D

func _ready():
	Global.current_run_gold = 0
	Global.gold = SaveManager.stats["gold"]
