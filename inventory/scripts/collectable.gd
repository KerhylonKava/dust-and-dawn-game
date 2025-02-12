extends StaticBody2D

@export var item: InvItem
var SootSprite = null



func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect()
		visible = false

func playercollect():
	SootSprite.collect(item)
