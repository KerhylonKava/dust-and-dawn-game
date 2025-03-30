extends Node2D
#@export var one_script : One_master
#@onready var one_script = $"../one_level"
#@onready var one_script = $"../one_level"
#var side = one_script.side #1=left, 2=right
@export var backpack : InvItem
@export var cave_key : InvItem
@export var left : InvItem
@export var right : InvItem
@onready var SootSprite = $SootSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if playercontains(right):
		print("right")
		$SootSprite.position.x = 50 #spawn on the left
		$SootSprite.position.y = 550
		playerremove(right,1)
	elif playercontains(left):
		print("left")
		playerremove(left,1)
		$SootSprite.position.x = 9900 #spawn on the right
	$SootSprite/Camera2D.position_smoothing_speed = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_right_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		if playercontains(cave_key):
			get_tree().change_scene_to_file("res://levels/1level/1level.tscn")
			$SootSprite/Camera2D.position_smoothing_speed = 0
		else:
			print("player no contain cave key")

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

func playerremove(item,amount):
	SootSprite.remove(item,amount)

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
