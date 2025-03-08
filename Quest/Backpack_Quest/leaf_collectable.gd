extends StaticBody2D

@export var leaf: InvItem
var SootSprite = null

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect(leaf,1)
		visible = false

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
	
	# Set a flag to indicate that the string sprite has been collected
	#SootSprite.has_collected_string_sprite = true
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
