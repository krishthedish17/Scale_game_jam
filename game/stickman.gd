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
var pause_times = 0
var slowed = false
var can_pause = true

@onready var dash = $dash
@onready var timer = $Stop_timer
@onready var stop_cooldown = $stop_cooldown
@onready var jump_sound = $"../AudioStreamPlayer"
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
			jump_sound.play()
			velocity.y = jump_velocity
			jump_count += 1
			print(jump_count)
			
	#handles wall slide.
	if is_on_wall() && (Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right")) && GameManager.level > 1:
		jump_count = 0
		if velocity.y >= 0:
			velocity.y = min(velocity.y + wall_slide_acceleration, max_wall_slide_Speed)
			
	if Input.is_action_just_pressed("dash") && GameManager.level > 2 && GameManager.dash_count <= 3 && GameManager.lock_player == false:
		print("dash")
		dash.start_dash(dash_length)
		print(GameManager.dash_count)
		GameManager.dash_count += 1
	if is_on_floor():
		GameManager.dash_count = 0
	var speed = dash_speed if dash.is_dashing() else current_speed
	if dash.is_dashing():
		dashing = true
	
	
	
			
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if GameManager.lock_player == false:
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	if GameManager.lock_player == false:
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
	time_stop()
	portal_anim()
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->

# Handle Player Animations
func player_animations():
	particle_trails = false
	
	if is_on_floor():
		if GameManager.lock_player == true:
			player_sprite.play("Idle")
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

	GameManager.load_death_scene()
	print(GameManager.level)
	print("i'm dead")
	

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
func time_stop():
	if Input.is_action_just_pressed("time stop") && pause_times == 0 && can_pause == true && GameManager.level >= 5:
		pause_times += 1
		can_pause = false
		GameManager.is_paused = true
		get_tree().paused = !get_tree().paused
		timer.start(3)

func _on_stop_timer_timeout():
	get_tree().paused = !get_tree().paused
	GameManager.is_paused = false
	pause_times = 0
	print(can_pause)
	stop_cooldown.start(3)
func _on_stop_cooldown_timeout():
	print(can_pause)
	can_pause = true
	
func portal_anim():
	if GameManager.level5win == true:
		$AnimatedSprite2D/AnimationPlayer.play("portal enter")
