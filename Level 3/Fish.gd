extends Node2D

@onready var fish_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animate_sprite()

func animate_sprite():
	fish_sprite.play("Idle")
	

	


func _on_area_2d_body_entered(body):
	if GameManager.scales_collected == 3:
		GameManager.level3win = true
		await get_tree().create_timer(3).timeout
		print("You beat level 3")
		GameManager.load_level_2_scene()
