extends RigidBody2D

var picked = false

func _physics_process(delta: float) -> void:
	if picked == true:
		self.position = get_node("../SootSprite/Marker2D").global_position #Check if sootsprite is named properly 

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pick"):
		var bodies = $Area2D.get_overlapping_bodies() #check for collision layers set up properly
		for body in bodies:
			if body.name == "SootSprite" and get_node("../SootSprite").canPick == true:
				picked = true
				get_node("../SootSprite").canPick = false
				
	if Input.is_action_just_pressed("drop") and picked == true:
		picked = false
		get_node("../SootSprite").canPick = true
		if get_node("../SootSprite/SootSpriteImage").flip_h == false: 
			set_sleeping(false)
			apply_impulse(Vector2(), Vector2(90, - 10)) 
		else:
			set_sleeping(false)
			apply_impulse(Vector2(), Vector2(-90, -10))
			
	if Input.is_action_just_pressed("throw") and picked == true: 
		picked = false
		get_node("../SootSprite").canPick = true
		if get_node("../SootSprite/SootSpriteImage").sprite.flip_h == false:
			set_sleeping(false)
			apply_impulse(Vector2(), Vector2(150, - 200)) 
		else:
			set_sleeping(false)
			apply_impulse(Vector2(), Vector2(-150, -200))
