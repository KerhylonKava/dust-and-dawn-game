extends Node2D
#@export var one_script : One_master
#@onready var one_script = $"../one_level"
#@onready var one_script = $"../one_level"
#var side = one_script.side #1=left, 2=right
var side = "right"
var player_in_door = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SootSprite/Camera2D.position_smoothing_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		#print("space")
		if player_in_door:
			#if playercontains(scene completion item):
			print("scene switch")
			get_tree().change_scene_to_file("res://levels/4level/4level.tscn")

func _on_door_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_door = true
		print("player in door")


func _on_door_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_door = false
