extends CharacterBody2D
const UP_DIRECITON := Vector2.UP


@export var speed := 450/0.0166
#scale.x = scale.y * direction 

@onready var animation = $AnimationPlayer
@onready var vine_ray_cast: RayCast2D = $VineRayCast
@export var inventory : Inventory
#@export var enough_items = inventory.enough_items

@export var climbing = false



var jump_time = 0
var jump_strength := 700/0.0166
var max_jumps := 2
var jumps_made := 0
var on_ladder = false
var is_falling := velocity.y > 0 and not is_on_floor()
var Jump_Force = -1100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	#if Input.is_action_just_pressed("space"):
		#collect(item)
	#Movement
	if jump_time > 0:
		jump_time -= 1
	
	if Input.is_action_just_pressed("up"):
		animation.play("jump")
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
		velocity.x = -speed * delta
	
	elif Input.is_action_pressed("right"):
		$SootSpriteImage.flip_h = false
		if is_on_floor():
			animation.play("run")
		velocity.x = speed * delta

	else:
		if velocity.x > 0:
			velocity.x -= 0.15 * velocity.x
		if velocity.x < 0:
			velocity.x -= 0.15 * velocity.x
		if velocity.x == 0 and is_on_floor():
			animation.play("idle")
			
	if jump_time > 0:
		velocity.y = -jump_strength * delta
	
	#Gravity
	velocity.y += 30 * delta / 0.0166

	move_and_slide()

func collect(item):
	inventory.insert(item)

func remove(item):
	inventory.remove(item)

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


	
