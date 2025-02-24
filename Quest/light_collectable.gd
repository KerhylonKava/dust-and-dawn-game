extends StaticBody2D

@export var item: InvItem
var SootSprite = null

# A signal to notify other scripts when the item is collected (optional)
signal light_sprite_collected

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect()
		visible = false

func playercollect():
	# Collect the item and trigger a signal
	SootSprite.collect(item)
	
	# Set a flag to indicate that the light sprite has been collected
	# This can be a global variable or a reference to the player's lantern state
	#var player = get_node("res://levels/soot_sprite/soot_sprite.gd") # Assuming the player is at this location
	SootSprite.has_collected_light_sprite = true
	
	# Optionally, you can emit a signal if you need to notify other parts of the game
	emit_signal("light_sprite_collected")
