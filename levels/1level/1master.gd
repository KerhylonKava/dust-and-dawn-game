extends Node2D
class_name One_master
@onready var SootSprite = $SootSprite
@export var backpack : InvItem
@export var left : InvItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SootSprite.position.x = 50
	$SootSprite/Camera2D.position_smoothing_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_left_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		if playercontains(backpack):
			get_tree().change_scene_to_file("res://levels/2level/2level.tscn")
			playercollect(left,1)
			if playercontains(left):
				print("left")
			$SootSprite/Camera2D.position_smoothing_speed = 0
		else:
			print("player no contain backpack")

func playercontains(item):
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
