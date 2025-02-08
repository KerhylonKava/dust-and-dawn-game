extends Camera2D

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open == false:
			is_open = true
			position.y -= 200
			position_smoothing_speed -= 1
		else:
			is_open = false
			position.y += 200
			position_smoothing_speed += 1
