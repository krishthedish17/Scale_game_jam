extends Node

var game_scene: PackedScene = preload("res://game/game.tscn")
var main_scene: PackedScene = preload("res://main/main.tscn")
var level_2_scene: PackedScene = preload("res://level 2/level_2.tscn")
var level_3_scene: PackedScene = preload("res://Level 3/level_3_scene.tscn")
var level_4_scene: PackedScene = preload("res://Level 4/level_4_scene.tscn")
var level_5_scene: PackedScene = preload("res://Level 5/level_5_scene.tscn")
var level_6_scene: PackedScene = preload("res://level 6 scene/level_6_scene.tscn")
var is_big : bool = false
var is_small: bool = false
var level: int = 1
var scales_collected: int = 0
var blocks_collected: int = 0
var level3win: bool = false
var level5win: bool = false
var level4win: bool = false
var dash_count: int = 0
var is_paused: bool = false
var fight_start: bool = false
var shooting_arm: bool = false
var second_phase: bool = false
var hit_shot: bool = false
var boss_dead: bool = false
func start():
	process_mode = Node.PROCESS_MODE_ALWAYS
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
	scales_collected = 0
func load_level_4_scene() -> void:
	get_tree().change_scene_to_packed(level_4_scene)
	level = 4
	GameManager.level5win = false
	blocks_collected = 0
	GameManager.level4win = false
func load_level_5_scene() -> void:
	get_tree().change_scene_to_packed(level_5_scene)
	level = 5
	GameManager.level5win = false
func load_level_6_scene() -> void:
	get_tree().change_scene_to_packed(level_6_scene)
	level = 6
	GameManager.level5win = false
var is_dragging = false
