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
	
