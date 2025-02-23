extends StaticBody2D

@export var item: InvItem
var SootSprite = null
var Light_Collected = false
@onready var Light_Sound = $Light_Sound

# A signal to notify other scripts when the item is collected (
signal light_sprite_collected

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite") and not Light_Collected:
		SootSprite = body
		playercollect()
		Light_Sound.play()
		visible = false
		Light_Collected = true

func playercollect():
	# Collect the item and trigger a signal
	SootSprite.collect(item)
	
	# Set a flag to indicate that the light sprite has been collected
	var player = get_node("/root/1level/SootSprite") 
	player.has_collected_light_sprite = true
	
#emit signal
	emit_signal("light_sprite_collected")
