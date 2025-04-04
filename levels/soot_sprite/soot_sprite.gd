extends CharacterBody2D
const UP_DIRECITON := Vector2.UP

@onready var is_moving = false
const WALL_SLIDING_SPEED = 1600

@export var speed := 450/0.0166
#scale.x = scale.y * direction 
@onready var FootSteps_Sound = $FootSteps_Sound
@onready var Jump_Sound = $Jump_Sound
@onready var animation = $AnimationPlayer
@onready var vine_ray_cast: RayCast2D = $VineRayCast
@export var inventory : Inventory
@export var backpack : InvItem
@export var cave_key : InvItem
@export var glow_crystal : InvItem
#@export var enough_items = inventory.enough_items

@export var climbing = false


var onAutoJumpObject: bool = false

var jump_time = 0
var jump_strength := 700/0.0166
var max_jumps := 1
var jumps_made := 0
var on_ladder = false
var is_falling := velocity.y > 0 and not is_on_floor()
var onAutoJumpOpject = false

var Jump_Force = -1100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("SootSprite")
	if !contains(backpack):
		size(3)
		
	elif contains(backpack):
		size(12)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if is_on_wall_only(): velocity.y = WALL_SLIDING_SPEED * delta
	if jump_time > 0:
		jump_time -= 1
	
	if Input.is_action_just_pressed("test"):
		collect(backpack,1)
		collect(cave_key,1)
		collect(glow_crystal,1)
		if !contains(backpack):
			size(3)
		elif contains(backpack):
			size(12)
	
	
	if Input.is_action_just_pressed("up"):
		animation.play("jump")
		Jump_Sound.play()
		if is_on_floor():
			jump_time = 15
			jumps_made = 1
		elif jumps_made < max_jumps:
			jump_time += 5
			jumps_made += 1
	
	elif Input.is_action_pressed("left"):
		$SootSpriteImage.flip_h = true
		if is_on_floor():
			animation.play("run")
			if not FootSteps_Sound.playing:
				FootSteps_Sound.play()
		if !is_on_floor():
			if FootSteps_Sound.playing:
				FootSteps_Sound.stop()
		velocity.x = -speed * delta
	
	elif Input.is_action_pressed("right"):
		$SootSpriteImage.flip_h = false
		if is_on_floor():
			animation.play("run")
			if not FootSteps_Sound.playing:
				FootSteps_Sound.play()
		if !is_on_floor():
			if FootSteps_Sound.playing:
				FootSteps_Sound.stop()
		velocity.x = speed * delta
	
	else:
		if velocity.x > 0:
			velocity.x -= 0.15 * velocity.x * delta / 0.0166
		if velocity.x < 0:
			velocity.x -= 0.15 * velocity.x * delta / 0.0166
		if velocity.x == 0 and is_on_floor():
			animation.play("idle")
			if FootSteps_Sound.playing:
				FootSteps_Sound.stop()
	
	
	if jump_time > 0:
		velocity.y = -jump_strength * delta
	
	#Gravity
	velocity.y += 30 * delta / 0.0166

	move_and_slide()
	


@warning_ignore("shadowed_variable")
func collect(item,amount):
	inventory.insert(item,amount)
	print(amount(item))

@warning_ignore("shadowed_variable")
func remove(item,amount):
	inventory.remove(item,amount)

func contains(item):
	if inventory.contains(item):
		#print("ifcontains checked: ", inventory.contains(item))
		return true
	elif !inventory.contains(item):
		#print("elifcontains checked: ", inventory.contains(item))
		return false

func amount(item):
	#print("soot", inventory.amount(item))
	return inventory.amount(item)

func size(size):
	inventory.size(size)
	
func soot_sprite():
	pass

"""
var has_collected_light_sprite = false
var has_collected_leaf_sprite = false
var has_collected_string_sprite = false
"""
func _physics_process(delta: float) -> void:
	var vineCollider = vine_ray_cast.get_collider()
	if vineCollider: _vine_climb(delta)
	
	if onAutoJumpOpject:
		if is_on_floor(): onAutoJumpOpject = false





func _vine_climb(delta):
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction: velocity = direction * speed / 80
	else: velocity = Vector2.ZERO
	#if Input.is_action_just_pressed("right") and Input.is_action_just_pressed("ui_up"):
		#velocity.y = Jump_Force * 0.7
	#if Input.is_action_just_pressed("left") and Input.is_action_just_pressed("ui_up"):
		#velocity.y = Jump_Force * 0.7

func reset_to_start():
	global_position = Vector2(200, 650)  
	#print(global_position)
