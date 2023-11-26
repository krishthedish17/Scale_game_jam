extends Node2D


var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var clicked: bool = false
func _process(delta):
	if Input.is_action_just_pressed(("click")):
		clicked = true
		print("clicking")
		
	if Input.is_action_just_released("click"):
		clicked = false
		print("not clicking")
	if draggable:
		if clicked == true:
			GameManager.is_dragging = true
			offset = get_local_mouse_position() - global_position
		if clicked == true:
			global_position = get_local_mouse_position() - offset
			
		elif clicked == false:
			GameManager.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self, "position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self,"global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
		
		

func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body


func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body
	


func _on_area_2d_mouse_entered():
	if not GameManager.is_dragging:
		draggable = true
		scale = Vector2(1.05,1.05)

func _on_area_2d_mouse_exited():
	if not GameManager.is_dragging:
		draggable = false
		scale = Vector2(1,1)
