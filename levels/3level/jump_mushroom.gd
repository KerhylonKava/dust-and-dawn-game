extends StaticBody2D

@export var jumpHeight = 2500

@export var flipH = false

func _ready(): 
	$Sprite2D.flip_h = flipH



func _on_area_2d_body_entered(body: Node2D):
	print("area entered")
	if "SootSprite" in body.name:
		print("SootSprite entered")
		var jumpDirection = -1 if $Sprite2D.flip_h else 1
		$AnimationPlayer.play("mushroom_animation")
		body.velocity = Vector2(jumpDirection, -jumpHeight * scale.x)
		body.onAutoJumpObject = true
	#else:
		#$AnimationPlayer.play("idle")
