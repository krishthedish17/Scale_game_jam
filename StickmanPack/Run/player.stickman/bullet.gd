extends AnimatedSprite2D



func ready():
	pass

@onready var bullet_area = $Area2D
@export var speed: float = 200
@export var max_distance: float = 225
@onready var bullet_sprite = $"."

var original_pos = Vector2(0, 0)
var shot_pos = Vector2(0, 0)
var distance = 0
var shooting = false
var shot = false
var shot_travel_done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if shot == false:
		#original_pos = get_node("../Stickman").position
		#print(self.visible)
	if Input.is_action_just_pressed("shoot") && shooting == false:
		GameManager.hit_shot = true
	"""
		position.x = get_node("../Stickman").position.x
		position.y = get_node("../Stickman").position.y
		shot_pos = get_node("../Stickman").position
		shot = true
		print(self.visible)
	if shot == true:
		print(str(self.visible) + "visible")
		if shot_travel_done == false:
			bullet_sprite.play("travel")
		shooting = true
		print(shooting)
		if shooting == true:
			self.visible = true
			if distance < max_distance:
				print("is it shooting?" + str(shooting))
				position.x += speed * delta
				print(position.x)
				print(str(distance) + "distance value")
				print(str(max_distance) + "max value")
				distance = position.x - shot_pos.x
			if distance > max_distance:
				print("bullet finished")
				print(str(distance) + "distance value")
				print(str(max_distance) + "max value")
				bullet_sprite.play("explode")
				await get_tree().create_timer(0.8).timeout
				shooting = false
				shot_travel_done = true
				self.visible = false
				position = original_pos
				distance = 0
				shot = false
		"""


func _on_bullet_connected(body):
	if body.is_in_group("boss"):
		GameManager.hit_shot == true
		print("hit boss w")
		bullet_sprite.play("explode")
		await get_tree().create_timer(0.8).timeout
		shooting = false
		self.visible = false
		shot_travel_done = true
		position = original_pos
		distance = 0
		shot = false
		

