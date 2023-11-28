extends Camera2D

const DEAD_ZONE = 160

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var _target = event.position - get_viewport().size * 0.5
		if _target.length() < DEAD_ZONE:
			self.position = Vector2(0,0)
		else:
			self.position = _target.normalized() * (_target.length() - DEAD_ZONE) * 0.5
func _process(delta):
	pass
	#if GameManager.level == 6:
		#zoom.x = 0.5
		#zoom.y = 0.5
	#else:
		#zoom.x = 1.2
		#zoom.y = 1.2
