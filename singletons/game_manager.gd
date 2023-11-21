extends Node

var game_scene: PackedScene = preload("res://game/game.tscn")
var main_scene: PackedScene = preload("res://main/main.tscn")
var level_2_scene: PackedScene = preload("res://level 2/level_2.tscn")
var level_3_scene: PackedScene = preload("res://Level 3/level_3_scene.tscn")
var is_big : bool = false
var is_small: bool = false
var level: int = 1

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)
	level = 1
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)
	
func load_level_2_scene() -> void:
	get_tree().change_scene_to_packed(level_2_scene)
	level = 2
func load_level_3_scene() -> void:
	get_tree().change_scene_to_packed(level_3_scene)
	level = 3
