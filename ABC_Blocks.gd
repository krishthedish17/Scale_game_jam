extends Node2D

@onready var block_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	animate_sprite()
func animate_sprite():
	block_sprite.play("Idle")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		GameManager.blocks_collected += 1
		queue_free()
		print("Blocks Collected " + str(GameManager.blocks_collected))
