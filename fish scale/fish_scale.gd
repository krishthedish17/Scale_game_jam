extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_scale_collected(body):
	if body.is_in_group("player"):
		GameManager.scales_collected += 1
		queue_free()
		print("Scales collected: " + str(GameManager.scales_collected))
