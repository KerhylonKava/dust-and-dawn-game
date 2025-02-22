extends StaticBody2D

@export var item: InvItem
var SootSprite = null



func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect()
		disable_and_hide_node(self)
		
func playercollect():
	SootSprite.collect(item)

func disable_and_hide_node(node:Node) -> void:
	#node.process_mode = 5 # = Mode: Disabled
	node.set_physics_process(false)
	node.hide()

func enable_and_show_node(node:Node) -> void:
	#node.process_mode = 0 # = Mode: Inherit
	node.set_physics_process(true)
	node.show()
