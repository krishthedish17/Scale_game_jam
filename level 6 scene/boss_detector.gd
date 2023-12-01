extends Area2D

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.lock_player = true
		await get_tree().create_timer(1.5).timeout
		GameManager.fight_start = true
		GameManager.lock_player = false
		GameManager.boss_music = true
		print("player detected")
		print(GameManager.fight_start)
		queue_free()
