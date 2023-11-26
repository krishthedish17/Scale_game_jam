extends Node2D


var selected = false

func _ready():
	pass


func _process(delta):
	if selected:
		followMouse()
		print(selected)

func followMouse():
	position = get_global_mouse_position()
	


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			#Mouse Clicked
			selected = true
	else:
		#Mouse Released
		selected = false
