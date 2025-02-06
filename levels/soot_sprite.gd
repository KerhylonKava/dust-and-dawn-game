extends CharacterBody2D

@export var speed := 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Movement
	var direction = Input.get_vector("left","right","up","down")
	velocity += direction * speed
	if not Input.get_vector("left","right","up","down"):
		if velocity.x > 0:
			velocity.x -= 0.5 * velocity.x
		if velocity.x < 0:
			velocity.x += 0.5 * velocity.x
#Gravity
	velocity.y = velocity.y + 50
	print(velocity.y)

	move_and_slide()
	
