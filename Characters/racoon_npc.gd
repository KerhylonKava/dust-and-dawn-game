extends Node2D

var SootSprite = null
var player_in_area = false
@onready var lantern = get_parent().get_node("LightingLantern")


@onready var anim = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")
	#var lantern = get_parent().get_node("LightingLantern")

func _process(delta):
	if player_in_area:
		$space.visible = true
	elif !player_in_area:
		$space.visible = false
	
	if player_in_area and Input.is_action_just_pressed("space"):
		if lantern.is_lantern_lit == true:
			$QuestBoard/NotLit.visible = false
			$QuestBoard/Lit.visible = true
			$QuestBoard.visible = true
		elif lantern.is_lantern_lit == false:
			$QuestBoard/NotLit.visible = true
			$QuestBoard/Lit.visible = false
			$QuestBoard.visible = true
	elif !player_in_area:
		$QuestBoard.visible = false
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body
