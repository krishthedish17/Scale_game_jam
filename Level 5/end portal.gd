extends Node2D

@onready var end_sprite = $"end sprite"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	

func _on_portal_entered(body):
	print("detected a body")
	if body.is_in_group("player"):
		print("detected as player")
		end_sprite.play("activated")
		GameManager.level5win = true
		await get_tree().create_timer(3).timeout
		print("You beat level 5")
		GameManager.load_level_4_scene()
	

