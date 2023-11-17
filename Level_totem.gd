extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_body_entered(body):
	#play victory sound
	await get_tree().create_timer(3).timeout
	#send signal to transfer to the next level from game manager
	print("you beat level 1")
	if GameManager.level == 1:
		GameManager.load_level_2_scene()
		
	
