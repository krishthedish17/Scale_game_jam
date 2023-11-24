extends TileMap

@export var show_time: int = 1
var timer: int = 0
@export var max_time: int = 8
var _timer = null
@onready var platform_timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	platform_appear()

func wait(x):
	platform_timer.wait_time = x
	platform_timer.start()
	print("timer done")
	return !platform_timer.is_stopped()

func platform_appear():
	timer += 1
	wait(1)
	print("timer done")
	if show_time == timer:
		self.visible = true
		timer = 0
		print("show")
	else:
		self.visible = false
		print("dont show")
