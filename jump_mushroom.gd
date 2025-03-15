extends StaticBody2D

@export var jumpHeight = 1850
#@export var jumpDistance = 200
@export var flipH = false

func _ready(): 
	$Sprite2D.flip_h = flipH



func _on_area_2d_body_entered(body: Node2D):
	if "SootSprite" in body.name:
		var jumpDirection = -1 if $Sprite2D.flip_h else 1
		
		body.velocity = Vector2(jumpDirection, -jumpHeight)
		body.onAutoJumpObject = true
