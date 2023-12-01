extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.fight_start == true:
		self.visible = true
	if GameManager.boss_dead == true:
		self.visible = false
