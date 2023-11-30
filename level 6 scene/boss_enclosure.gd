extends TileMap

@onready var collision = $StaticBody2D/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	collision.set_deferred("disabled", true)
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.fight_start == true:
		self.visible = true
		collision.set_deferred("disabled", false)
