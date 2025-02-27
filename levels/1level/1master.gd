extends Node2D
class_name One_master

@export var side = 'left'
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if side == 'left':
		$SootSprite.position.x = 50
	elif side == 'right':
		$SootSprite.position.x = 4950
	$SootSprite/Camera2D.position_smoothing_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_left_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		side = 'left'
		print(side,"first")
		get_tree().change_scene_to_file("res://levels/2level/2level.tscn")
		$SootSprite/Camera2D.position_smoothing_speed = 0
