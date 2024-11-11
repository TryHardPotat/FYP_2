extends Node

## Spawner Requirements
var character_scenes = {
	"Scout": preload("res://scenes/entities/scout.tscn"),
	"Slingshot": preload("res://scenes/entities/slingshot.tscn"),
	"Spellcaster": preload("res://scenes/entities/spellcaster.tscn")
}
var selected_character : PackedScene = null
var selected_subclass : String
var dungeon_width : int = 5
var dungeon_height : int = 5

## Player Gold
var current_run_gold : int = 0
var gold : int = 0
