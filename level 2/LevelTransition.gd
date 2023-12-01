extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _on_area_2d_body_entered(body):
	await get_tree().create_timer(1).timeout
	print("You beat level 2")
	GameManager.load_level_3_scene()
