extends CharacterBody2D
const UP_DIRECITON := Vector2.UP

@export var speed := 450/0.0166
#scale.x = scale.y * direction 

@onready var animation = $AnimationPlayer

@export var inventory : Inventory
@export var backpack : InvItem
#@export var enough_items = inventory.enough_items

var jump_time = 0
var jump_strength := 700/0.0166
var max_jumps := 2
var jumps_made := 0

var is_falling := velocity.y > 0 and not is_on_floor()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !contains(backpack):
		size(3)
		
	elif contains(backpack):
		size(12)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#inventory.slots.size -=10
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

@warning_ignore("shadowed_variable")
func collect(item,amount):
	inventory.insert(item,amount)

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
