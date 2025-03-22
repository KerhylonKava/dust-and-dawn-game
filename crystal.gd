extends StaticBody2D

@export var crystal: InvItem
var SootSprite = null


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect(crystal,1)
		queue_free()

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
