extends Node2D
@onready var SootSprite = $SootSprite
@export var backpack : InvItem
@export var GlowCrystal : InvItem
@export var right : InvItem
@export var left : InvItem

const doorpath = "res://levels/3level/door.tscn"
var door = preload(doorpath).instantiate()
var in_door = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SootSprite.position.x = 75
	$SootSprite/Camera2D.position_smoothing_speed = 5
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_left_world_border_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		if playercontains(GlowCrystal):
			get_tree().change_scene_to_file("res://levels/2level/2level.tscn")
			playercollect(right,1)
			$SootSprite/Camera2D.position_smoothing_speed = 0
	
func playercontains(item):
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playercontains(GlowCrystal):
		if !$Door:
			#var doorinstance = door.instantiate()
			add_child(door)
			print("added child")
			if $Door:
				print("there be dor")
				$Door.position.x = 1250
				$Door.position.y = 600
				$Door.scale.x = 5
				$Door.scale.y = 5
			var area_node = $Door/Area2D
			if area_node:
				print("area node xist")
			elif !area_node:
				print("no be area node")
		if $Door:
			in_door = $Door.player_in_area
			if in_door:
				if Input.is_action_just_pressed("space"):
					get_tree().change_scene_to_file("res://levels/3level/3level.tscn")

func playercollect(item,amount):
	# Collect the item and trigger a signal
	SootSprite.collect(item,amount)
