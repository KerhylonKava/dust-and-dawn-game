extends StaticBody2D

@export var light: InvItem
var SootSprite = null
@onready var Light_Sound = $Light_Sound

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect(light,1)
		Light_Sound.play()
		queue_free()

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
