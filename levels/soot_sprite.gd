extends CharacterBody2D

@export var speed := 750
var jumpTime = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Movement
	if jumpTime > 0:
		jumpTime -= 1
		print(jumpTime)
	
	if Input.is_action_just_pressed("up"):
		#if collisionShape2D:
		if jumpTime == 0:
			jumpTime = 15
		print(jumpTime)
	
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	
	elif Input.is_action_pressed("right"):
		velocity.x = speed

	else:
		if velocity.x > 0:
			velocity.x -= 0.15 * velocity.x
		if velocity.x < 0:
			velocity.x -= 0.15 * velocity.x
			
	if jumpTime > 0:
		velocity.y = -speed
	
	#Gravity
	velocity.y += 50

	move_and_slide()
	
