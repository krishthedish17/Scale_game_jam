extends TileMap

var timer: int = 0
@export var max_platforms: int = 4
@export var activate_time: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.visible = true

func appear():
	self.visible = true
	pass
