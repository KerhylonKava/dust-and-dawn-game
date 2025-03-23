extends Node2D
#@export var one_script : One_master
#@onready var one_script = $"../one_level"
#@onready var one_script = $"../one_level"
#var side = one_script.side #1=left, 2=right
var side = "right"
@export var backpack : InvItem
@export var cave_key : InvItem
var SootSprite = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(side)
	if side == 'left':
		$SootSprite.position.x = 50
	elif side == 'right':
		$SootSprite.position.x = 9950
	$SootSprite/Camera2D.position_smoothing_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_right_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		if playercontains(backpack):
			get_tree().change_scene_to_file("res://levels/1level/1level.tscn")
			side = 'right'
			$SootSprite/Camera2D.position_smoothing_speed = 0
		else:
			print("player no contain backpack")

func _on_left_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		if playercontains(cave_key):
			get_tree().change_scene_to_file("res://levels/4level/4level.tscn")

func playercontains(item):
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false
