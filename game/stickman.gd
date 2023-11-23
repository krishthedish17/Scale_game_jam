extends CharacterBody2D

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400
@export var jump_force : float = 600
@export var max_jump_count : int = 2
var jump_count : int = 0
var wall_slide_acceleration = 10
var max_wall_slide_Speed = 120
var dash_speed = 1800
var dash_length = 0.1
var in_water = false
var water_grav = 0.25
var water_speed = 0.25

@onready var dash = $dash


@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false

var is_grounded : bool = false
var jump_velocity: float = -400
var base_speed: float = 300
var small_speed: float = base_speed * 2
var large_speed: float = base_speed / 2
var current_speed: float = base_speed
var speed: float = base_speed
var dashing = false

@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var particle_trails = $ParticleTrails
@onready var death_particles = $DeathParticles
@onready var collision_shape = $CollisionShape2D
@onready var collision_hitbox = $Collision
@onready var stickman = $"."
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("Player")
	print(in_water)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if in_water == true:
			velocity.y += gravity * delta * water_grav
			speed = base_speed * water_speed
		else:
			velocity.y += gravity * delta
			speed = base_speed
	if not dash.is_dashing():
		dashing = false
		
	if is_on_floor() and jump_count != 0:
		jump_count = 0

	# Handle Jump.
	if jump_count < max_jump_count:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity
			jump_count += 1
			print(jump_count)
			
	#handles wall slide.
	if is_on_wall() && (Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")) && GameManager.level > 1:
		jump_count = 0
		if velocity.y >= 0:
			velocity.y = min(velocity.y + wall_slide_acceleration, max_wall_slide_Speed)
			
	if Input.is_action_just_pressed("dash") && GameManager.level > 2:
		print("dash")
		dash.start_dash(dash_length)
	var speed = dash_speed if dash.is_dashing() else current_speed
	if dash.is_dashing():
		dashing = true
	
	
	
			
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	

# --------- VARIABLES ---------- #



# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	# Calling functions
	player_animations()
	flip_player()
	shrink()
	grow()
	restart()
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->

# Handle Player Animations
func player_animations():
	particle_trails = false
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			particle_trails = true
			player_sprite.play("Sprint", 1.5)
		else:
			player_sprite.play("Idle")
	else:
		player_sprite.play("Jump")
	if is_on_wall() && GameManager.level > 1:
		player_sprite.play("Wall_Cling")
	if Input.is_action_just_pressed("dash") && GameManager.level > 2:
			if velocity.x >= 0:
				self.set_rotation_degrees(90)
			else:
				self.set_rotation_degrees(-90)
			while dashing == true:
				player_sprite.play("Dash")
				await get_tree().create_timer(0.1).timeout
			self.set_rotation_degrees(0)
		
		

# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x >= 0:
		player_sprite.flip_h = false

# Tween Animations
func death():
	#death_particles.emitting = true
	print(GameManager.level)
	print("I'm dead")
	if GameManager.level == 1:
		GameManager.load_game_scene()
	elif GameManager.level == 2:
		GameManager.load_level_2_scene()
	elif GameManager.level == 3:
		GameManager.load_level_3_scene()
	elif GameManager.level == 4:
		GameManager.load_level_4_scene()
	elif GameManager.level == 5:
		GameManager.load_level_5_scene()
	elif GameManager.level == 6:
		GameManager.load_level_6_scene()
	elif GameManager.level == 7:
		GameManager.load_level_7_scene()
	

func shrink():
	if Input.is_action_just_pressed("shrink") && not GameManager.is_small: 
		if GameManager.is_big == true:
			player_sprite.scale = Vector2(1, 1)
			collision_shape.scale = Vector2(1, 1)
			collision_hitbox.scale = Vector2(1, 1)
			GameManager.is_big = false
			jump_velocity = -400
			speed = base_speed
			current_speed = speed
			player_sprite.speed_scale = 1
		else:
			player_sprite.scale = Vector2(0.4, 0.4)
			collision_shape.scale = Vector2(0.4, 0.4)
			collision_hitbox.scale = Vector2(0.4, 0.4)
			GameManager.is_small = true
			jump_velocity = -200
			speed = small_speed
			current_speed = speed
			player_sprite.speed_scale = 2
		

func grow():
	if Input.is_action_just_pressed("grow") && not GameManager.is_big:
		if GameManager.is_small == true:
			player_sprite.scale = Vector2(1, 1)
			player_sprite.speed_scale = 1
			collision_shape.scale = Vector2(1, 1)
			collision_hitbox.scale = Vector2(1, 1)
			jump_velocity = -400
			GameManager.is_small = false
			speed = base_speed
			current_speed = speed
		else:
			player_sprite.speed_scale = 0.5
			player_sprite.scale = Vector2(2, 2)
			collision_shape.scale = Vector2(2, 2)
			collision_hitbox.scale = Vector2(2, 2)
			jump_velocity = -800
			speed = large_speed
			current_speed = speed
			GameManager.is_big = true
		
	




func _on_link_hooked(hooked_position):
	await get_tree().create_timer(0.2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", hooked_position,0.375)
	jump_count = 0

func water():
	print("swim")
	in_water = true

func not_water():
	print("no swim :(")
	in_water = false

func restart():
	if Input.is_action_just_pressed("restart"):
		death()
		
