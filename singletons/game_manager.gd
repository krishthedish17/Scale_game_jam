extends Node

var game_scene: PackedScene = preload("res://game/game.tscn")
var main_scene: PackedScene = preload("res://main/main.tscn")
var is_big : bool = false
var is_small: bool = false

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)
