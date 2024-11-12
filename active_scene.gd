extends Node2D

func _ready():
	Global.current_run_gold = 0
	Global.player_exp = 1
	Global.player_exp = 0
	Global.gold = SaveManager.stats["gold"]
