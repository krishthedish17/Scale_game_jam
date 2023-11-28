extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if GameManager.level4win == true:
		print("You beat level 4")
		await get_tree().create_timer(3).timeout
		GameManager.load_level_5_scene()
