extends RigidBody2D

var picked = false

func _physics_process(delta: float) -> void:
	if picked == true:
		self.position = get_node("../SootSprite/Marker2D").global_position

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("space"):
		var bodies = $Area2D.get_overlapping_bodies() 
		for body in bodies:
			if body.name == "SootSprite" and get_node("../SootSprite").canPick == true:
				#self.freeze = true
				#self.freeze_mode = RigidBody2D.FREEZE_MODE_STATIC #Check if need to remove freeze
				picked = true
				get_node("../SootSprite").canPick = false
				
	if Input.is_action_just_pressed("drop") and picked == true:
		picked = false
		get_node("../SootSprite").canPick = true
		if get_node("../SootSprite/SootSpriteImage").flip_h == false: 
			linear_velocity = Vector2(90, -10)
		else:
			linear_velocity = Vector2(-90, -10)
			
	if Input.is_action_just_pressed("throw") and picked == true: 
		picked = false
		get_node("../SootSprite").canPick = true
		picked = false
		if get_node("../SootSprite/SootSpriteImage").flip_h == false:
			print("Throwing!")
			linear_velocity = Vector2(300, -300)  #stronger force
		else:
			linear_velocity = Vector2(-300, -300)
