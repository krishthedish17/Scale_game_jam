extends Node2D

var animation_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_played = false
	if animation_played == false:
		$AnimationPlayer.play("dissolve")
		animation_played = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play_backwards("dissolve")
		if GameManager.level == 1:
			GameManager.load_game_scene()
		elif GameManager.level == 2:
			GameManager.load_level_2_scene()
		elif GameManager.level == 3:
			GameManager.load_level_3_scene()
		elif GameManager.level == 4:
			GameManager.load_level_4_scene()
		elif GameManager.level == 5:
			GameManager.load_level_5_scene()
		elif GameManager.level == 6:
			GameManager.load_level_6_scene()
		elif GameManager.level == 7:
			GameManager.load_level_7_scene()

