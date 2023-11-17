extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	is_in_group("Traps")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_void_entered(body):
	if is_in_group("player"):
		body.death_tween()
