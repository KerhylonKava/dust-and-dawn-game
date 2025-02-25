extends StaticBody2D

@export var item: InvItem
var SootSprite = null

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect()
		visible = false

func playercollect():
	# Collect the item and trigger a signal
	SootSprite.collect(item)
	
	# Set a flag to indicate that the light sprite has been collected
	SootSprite.has_collected_leaf_sprite = true
	
	# Optionally, you can emit a signal if you need to notify other parts of the game
	#emit_signal("leaf_sprite_collected")


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
