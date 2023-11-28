extends Node2D

var health = 100
@onready var sprite = $AnimatedSprite2D
@onready var boss = $AnimatedSprite2D/CharacterBody2D
@onready var cooldown = $cooldown
@onready var bullet = $AnimatedSprite2D/bullets

var idle = false
var shooting_arm = false
var shooting_chest = false
var moving = false
var go_back = false
var dead = false
var intro = false
var can_attack = false
var boss_attack = RandomNumberGenerator.new()
var started_fight = false
var current_attack = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started_fight != true:
		start_fight()
	if GameManager.fight_start == true || started_fight == true:
		animate()
		if can_attack == true:
			choose_attack()
			print("attack chosen")
			#await get_tree().create_timer(5).timeout
			#print("post timer")
	
func _physics_process(delta):
	if moving == true:
		boss.position.x += 200

func animate():
	#print("animating")
	#print(shooting_chest)
	#print(shooting_arm)
	#print(dead)
	#print(moving)
	#print(idle)
	#print(intro)
	if shooting_chest == true:
		sprite.play("shooting chest")
		print("shooting chest")
	if shooting_arm == true:
		sprite.play("shooting arm")
		print("shooting arm")
	if dead == true:
		sprite.play("dead")
	if health == 25:
		sprite.play("low health")
	#if moving == true:
		#sprite.play("move")
		#print("drifting")
	if idle == true:
		sprite.play("idle")
	if intro == true:
		sprite.play("intro")

func choose_attack():
	print("choosing attack")
	can_attack = false
	var current_attack = boss_attack.randi_range(1, 4)
	print(current_attack)
	if current_attack == 1:
		idle = true
		print("idle" + str(idle))
	#if current_attack == 2:
		#idle = false
		#moving = true
		#print("moving" + str(moving))
		#await get_tree().create_timer(2).timeout
		#moving = false
	if current_attack == 2:
		idle = false
		shooting_arm = true
		GameManager.shooting_arm = true
		print("shooting arm" + str(shooting_arm))
		await get_tree().create_timer(2).timeout
		shooting_arm = false
		GameManager.shooting_arm = false
	if current_attack == 3:
		idle = false
		shooting_chest = true
		GameManager.shooting_arm = true
		print("shooting chest" + str(shooting_chest))
		await get_tree().create_timer(2).timeout
		shooting_chest = false
		GameManager.shooting_arm = false
	if current_attack == 4:
		idle = false
		shooting_arm = true
		GameManager.shooting_arm = true
		print("shooting arm" + str(shooting_arm))
		await get_tree().create_timer(2).timeout
		shooting_arm = false
		GameManager.shooting_arm = false
	go_back = true
	idle = true
	await get_tree().create_timer(2).timeout
	can_attack = true
func start_fight():
	if GameManager.fight_start == true:
		print("ready to fight")
		started_fight = true
		idle = false
		sprite.play("intro")
		await get_tree().create_timer(1).timeout
		idle = true
		await get_tree().create_timer(2).timeout
		can_attack = true
		print("set attacking to true")
		GameManager.fight_start = false
		
		
