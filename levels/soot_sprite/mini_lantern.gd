extends CharacterBody2D

@export var speed := 5#450/0.0166

@onready var target = get_parent().get_node("SootSprite")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target: 
		if global_position.distance_to(target.global_position) < 150:
			velocity = Vector2.ZERO # Stop moving
			#velocity.y -= 15
			#move_and_slide()
		else:
			var direction = (target.global_position - global_position).normalized()
			velocity = direction * speed * (global_position.distance_to(target.global_position)-150)
			move_and_slide()
