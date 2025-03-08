extends StaticBody2D

@export var string: InvItem
var SootSprite = null

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect(string,1)
		visible = false

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
