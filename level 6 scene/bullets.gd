extends Node2D

@onready var bullet_area = $Area2D
@export var speed: float = 175
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
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	shooting = false
	GameManager.shooting_arm = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.second_phase == true:
		speed = 225
	else:
		speed = 175
	if weapon_selected == false:
		weapon = randi_range(1, 3)
	if weapon == 1:
		weapon_selected = true
		bullet_sprite.play("fireball")
		if GameManager.shooting_arm == true || shooting == true:
			print("i am sending a bullet:" + str(GameManager.shooting_arm))
			shooting = true
			self.visible = true
			position.x += speed * delta
			position.y = player.position.y
			print(position.x)
			if distance < max_distance:
				distance = position.x - original_pos
			else:
				position.x = original_pos
				self.visible = false
				distance = 0
				shooting = false
				weapon_selected = false
	if weapon == 2:
		weapon_selected = true
		bullet_sprite.play("fire tornado")
		if GameManager.shooting_arm == true || shooting == true:
			print("i am sending a bullet:" + str(GameManager.shooting_arm))
			shooting = true
			self.visible = true
			position.x += speed * delta
			print(position.x)
			if distance < max_distance:
				distance = position.x - original_pos
				if distance > (max_distance / 8):
					position.y = original_height + 32
			else:
				position.x = original_pos
				self.visible = false
				distance = 0
				shooting = false
				weapon_selected = false
	if weapon == 3:
		if boomerang_selected == false:
			if GameManager.second_phase == false:
				boomerang_type = randi_range(1, 2)
			boomerang_selected = true
		if GameManager.second_phase == true:
			boomerang_type = randi_range(1, 2)
			boomerang_selected = true
		weapon_selected = true
		bullet_sprite.play("fire boomerang")
		if GameManager.shooting_arm == true || shooting == true:
			print("i am sending a bullet:" + str(GameManager.shooting_arm))
			print("bullet is boomerang")
			shooting = true
			going_forward = true
			self.visible = true
			if going_forward == true:
				position.x += speed * delta
				position.y = player.position.y
			print(position.x)
			if distance < max_distance && going_forward == true:
				distance = position.x - original_pos
			if distance >= max_distance:
				going_forward = false
			if going_forward == false:
				print(going_forward)
				if position.x > original_pos && going_forward == false:
					print("going back")
					position.x -= speed * delta * 2
					if boomerang_type == 1:
						position.y = original_height + 32
					elif boomerang_type == 2:
						position.y = original_height
				else:
					position.x = original_pos
					self.visible = false
					distance = 0
					shooting = false
					weapon_selected = false
					boomerang_selected = false


func _on_bullet_connected(body):
	if body.is_in_group("player"):
		body.death()
		print("bro got shot rip")
