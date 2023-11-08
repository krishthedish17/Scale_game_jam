extends CharacterBody2D

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 400
@export var jump_force : float = 600
@export var max_jump_count : int = 2
var jump_count : int = 0

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false

var is_grounded : bool = false
var is_big : bool = false
var is_small: bool = false
var jump_velocity: float = -400
var speed: float = 300

@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var particle_trails = $ParticleTrails
@onready var death_particles = $DeathParticles
@onready var collision_shape = $CollisionShape2D
@onready var collision_hitbox = $Collision

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
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
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

# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false

# Tween Animations
func death():
	#death_particles.emitting = true
	print("I'm dead")

func shrink():
	if Input.is_action_just_pressed("shrink"):
		if is_big == true:
			print("im normal")
			player_sprite.scale = Vector2(1, 1)
			collision_shape.scale = Vector2(1, 1)
			collision_hitbox.scale = Vector2(1, 1)
			is_big = false
			jump_velocity = jump_velocity / 2
			speed = speed * 2
			player_sprite.speed_scale = 1
		else:
			print("im shrunk")
			player_sprite.scale = Vector2(0.5, 0.5)
			collision_shape.scale = Vector2(0.5, 0.5)
			collision_hitbox.scale = Vector2(0.5, 0.5)
			is_small = true
			jump_velocity = jump_velocity / 2
			speed = speed * 2
			player_sprite.speed_scale = 2
		

func grow():
	if Input.is_action_just_pressed("grow"):
		if is_small == true:
			print("im normal")
			player_sprite.scale = Vector2(1, 1)
			player_sprite.speed_scale = 1
			collision_shape.scale = Vector2(1, 1)
			collision_hitbox.scale = Vector2(1, 1)
			jump_velocity = jump_velocity * 2
			is_small = false
			speed = speed / 2
		else:
			print("im growing")
			player_sprite.speed_scale = 0.5
			player_sprite.scale = Vector2(2, 2)
			collision_shape.scale = Vector2(2, 2)
			collision_hitbox.scale = Vector2(2, 2)
			jump_velocity = jump_velocity * 2
			speed = speed / 2
			is_big = true
		
	


