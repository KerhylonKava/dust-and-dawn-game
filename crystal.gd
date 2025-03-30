extends StaticBody2D
@export var GlowCrystal : InvItem
@export var crystal: InvItem
@onready var SootSprite = get_parent().get_parent().get_node("SootSprite")

func _ready() -> void:
	if playercontains(GlowCrystal):
		queue_free()
		print("removed from scene")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect(crystal,1)
		queue_free()

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)

func playercontains(item):
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false
