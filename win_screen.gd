extends Node2D



var animation_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_played = false
	if animation_played == false:
		$ColorRect/AnimationPlayer.play("dissolve")
		animation_played = true
