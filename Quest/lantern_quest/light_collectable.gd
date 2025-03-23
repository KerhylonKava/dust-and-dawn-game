extends StaticBody2D

@export var light: InvItem
@export var cave_key: InvItem
@onready var SootSprite = get_parent().get_parent().get_node("SootSprite")
@onready var Light_Sound = $Light_Sound

func _ready():
	if playercontains(cave_key):
		print("remove ",self.name)
		queue_free()
	else:
		pass

func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		playercollect(light,1)
		Light_Sound.play()
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
