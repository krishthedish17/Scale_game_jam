extends Node2D

@onready var bullet_area = $Area2D
@export var speed: float = 200
@export var max_distance: float = 225
@onready var player = $"../../../Player"
@onready var bullet_sprite = $AnimatedSprite2D
var original_pos = position.x
var original_height = position.y
var distance = 0
var shooting = false
var fireball = false
var tornado = false
var boomerang = false
var weapon_type = RandomNumberGenerator.new()
var boomerang_type = 0
var boomerang_selected = false
var weapon = 0
var weapon_selected = false
var going_forward = false
var can_send = true
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false
	GameManager.shooting_arm = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("second_phase" + str(GameManager.second_phase))
	if GameManager.second_phase == true && can_send == true:
		bullet_sprite.play("fire tornado")
		can_send = false
		print("i am sending a bullet:" + str(GameManager.shooting_arm))
		self.visible = true
		position.x += speed * delta
		print(position.x)
		if distance < max_distance:
			distance = position.x - original_pos
			if distance > (max_distance / 8):
				position.y = original_height + 32
		if distance > max_distance:
			can_send = true
			position.x = original_pos
			position.y = original_height
			


func _on_bullet_connected(body):
	if body.is_in_group("player"):
		body.death()
		print("bro got shot rip")
