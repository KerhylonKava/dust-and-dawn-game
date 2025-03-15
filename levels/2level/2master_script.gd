extends Node2D
#@export var one_script : One_master
#@onready var one_script = $"../one_level"
#@onready var one_script = $"../one_level"
#var side = one_script.side #1=left, 2=right
var side = "left"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(side)
	if side == 'left':
		$SootSprite.position.x = 50
	elif side == 'right':
		$SootSprite.position.x = 4950
	$SootSprite/Camera2D.position_smoothing_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_right_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		get_tree().change_scene_to_file("res://levels/1level/1level.tscn")
		side = 'right'
		$SootSprite/Camera2D.position_smoothing_speed = 0
