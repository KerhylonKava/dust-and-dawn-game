extends CharacterBody2D
const UP_DIRECITON := Vector2.UP

@export var speed := 450

@export var inventory : Inventory

var jump_time = 0
var jump_strength := 700
var max_jumps := 2
var jumps_made := 0

var is_falling := velocity.y > 0 and not is_on_floor()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Movement
	if jump_time > 0:
		jump_time -= 1
		print(jump_time)
	
	if Input.is_action_just_pressed("up"):
		#if collisionShape2D:
		if is_on_floor():
			jump_time = 15
			jumps_made = 1
		elif jumps_made < max_jumps:
			jump_time += 5
			jumps_made += 1
		print(jump_time,",", jumps_made)
	
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	
	elif Input.is_action_pressed("right"):
		velocity.x = speed

	else:
		if velocity.x > 0:
			velocity.x -= 0.15 * velocity.x
		if velocity.x < 0:
			velocity.x -= 0.15 * velocity.x
			
	if jump_time > 0:
		velocity.y = -jump_strength
	
	#Gravity
	velocity.y += 30

	move_and_slide()
	
	#func collect(item):
	#	inv.insert(item)
	
