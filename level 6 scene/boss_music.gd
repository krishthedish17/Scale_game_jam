extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.boss_music == true:
		play()
		GameManager.boss_music = false
	if GameManager.boss_dead == true:
		stop()
