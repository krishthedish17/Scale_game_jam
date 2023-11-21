extends Node2D

@export var level_mark = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("you started a new level")
	if level_mark == 1:
		GameManager.level = 1
	if level_mark == 2:
		GameManager.level = 2
	if level_mark == 3:
		GameManager.level = 3
	if level_mark == 4:
		GameManager.level = 4
	if level_mark == 5:
		GameManager.level = 5
	if level_mark == 6:
		GameManager.level = 6
	if level_mark == 7:
		GameManager.level = 7
	print(GameManager.level)
