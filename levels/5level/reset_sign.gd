extends Node2D

var crate_scene = preload("res://levels/5level/crate.tscn") 
var SootSprite = null
var player_in_area = false
@onready var crate2 = $Crate2
@onready var crate3 = $Crate3
@onready var crate4 = $Crate4
@onready var crate5 = $Crate5



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crate2.global_position = Vector2(2372, -177) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		$space.visible = true
	elif !player_in_area:
		$space.visible = false

	
	if Input.is_action_just_pressed("space") and player_in_area:
		remove_child(crate2)
		add_child(crate2)
		crate2.global_position = Vector2(2372, -177)
		remove_child(crate3)
		add_child(crate3)
		crate3.global_position = Vector2(2372,-292)
		remove_child(crate4)
		add_child(crate4)
		crate4.global_position = Vector2(2372, -409)
		remove_child(crate5)
		add_child(crate5)
		crate5.global_position = Vector2(2372, -500)
