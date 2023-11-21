extends CharacterBody2D

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400
@export var jump_force : float = 600
@export var max_jump_count : int = 2
var jump_count : int = 0
var wall_slide_acceleration = 10
var max_wall_slide_Speed = 120


@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false

var is_grounded : bool = false
var jump_velocity: float = -400
var speed: float = 300

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


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor() and jump_count != 0:
		jump_count = 0

	# Handle Jump.
	if jump_count < max_jump_count:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity
			jump_count += 1
			print(jump_count)
			
	#handles wall slide.
	if is_on_wall(): #&& (Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")):
		jump_count = 0
		if velocity.y >= 0:
			velocity.y = min(velocity.y + wall_slide_acceleration, max_wall_slide_Speed)
			
		
			
	
		

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
	if is_on_wall():
		if velocity.x < 0:
			player_sprite.play("wall cling left")
		elif velocity.x > 0:
			player_sprite.play("wall cling right")
		

# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x >= 0:
		player_sprite.flip_h = false

# Tween Animations
func death():
	#death_particles.emitting = true
	print("I'm dead")
	if GameManager.level == 1:
		GameManager.load_game_scene()
	elif GameManager.level == 2:
		GameManager.load_level_2_scene()

func shrink():
	if Input.is_action_just_pressed("shrink"):
		if GameManager.is_big == true:
			player_sprite.scale = Vector2(1, 1)
			collision_shape.scale = Vector2(1, 1)
			collision_hitbox.scale = Vector2(1, 1)
			GameManager.is_big = false
			jump_velocity = -400
			speed = 400
			player_sprite.speed_scale = 1
		else:
			player_sprite.scale = Vector2(0.5, 0.5)
			collision_shape.scale = Vector2(0.5, 0.5)
			collision_hitbox.scale = Vector2(0.5, 0.5)
			GameManager.is_small = true
			jump_velocity = -200
			speed = 800
			player_sprite.speed_scale = 2
		

func grow():
	if Input.is_action_just_pressed("grow"):
		if GameManager.is_small == true:
			player_sprite.scale = Vector2(1, 1)
			player_sprite.speed_scale = 1
			collision_shape.scale = Vector2(1, 1)
			collision_hitbox.scale = Vector2(1, 1)
			jump_velocity = -400
			GameManager.is_small = false
			speed = 400
		else:
			player_sprite.speed_scale = 0.5
			player_sprite.scale = Vector2(2, 2)
			collision_shape.scale = Vector2(2, 2)
			collision_hitbox.scale = Vector2(2, 2)
			jump_velocity = -800
			speed = 200
			GameManager.is_big = true
		
	




func _on_link_hooked(hooked_position):
	await get_tree().create_timer(0.2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", hooked_position,0.375)
	jump_count = 0

	
