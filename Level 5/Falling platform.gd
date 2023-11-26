extends TileMap

@onready var timer = $Timer
var velocity = Vector2()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var reset_time: float = 1.0

@onready var reset_position = global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		velocity = Vector2.ZERO
		set_physics_process(true)
		timer.start(reset_time)




func _on_timer_timeout():
	set_physics_process(false)
	global_position = reset_position
