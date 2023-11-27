extends Node2D

@onready var weight_sprite  = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not GameManager.blocks_collected == 3:
		animate_sprite()
func animate_sprite():
	weight_sprite.play("Idle")

func _on_area_2d_body_entered(body):
	if GameManager.blocks_collected == 3:
		GameManager.level4win = true
		await get_tree().create_timer(3).timeout
		weight_sprite.play("activate_door")
		print("You opened level 4 door")

