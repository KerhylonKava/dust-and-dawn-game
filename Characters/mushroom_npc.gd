extends Node2D

var SootSprite = null
var player_in_area = false
@export var water : InvItem
@onready var p1 = get_parent().get_node("FlowerPot")
@onready var p2 = get_parent().get_node("FlowerPot2")
@onready var p3 = get_parent().get_node("FlowerPot3")


@onready var scene = get_parent().name
@onready var animated_sprite_2d = $"Animated Sprite"
#@onready var anim = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$QuestBoards/MushroomQuestBoard.visible = false
	animated_sprite_2d.play("default")


func _process(delta):
	if player_in_area:
		$space.visible = true
	elif !player_in_area:
		$space.visible = false
		$QuestBoards.visible = false
	
	if player_in_area and Input.is_action_just_pressed("space"):
		print("space")
		if scene == '3level':
			$QuestBoards/MushroomQuestBoard.visible =  true
			if p1.grown and p2.grown and p3.grown:
				$QuestBoards/MushroomQuestBoard/NotFixed.visible = false
				$QuestBoards/MushroomQuestBoard/Fixed.visible = true
				$QuestBoards.visible = true
				print("true")
				#playerremove(water, 10)
				
			else:
				$QuestBoards/MushroomQuestBoard/NotFixed.visible = true
				$QuestBoards/MushroomQuestBoard/Fixed.visible = false
				$QuestBoards.visible = true
				print("false")
				#playercollect(water,9) #cheat for testing


	
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

func playerremove(item,amount):
	SootSprite.remove(item,amount)


func playercollect(item,amount):
	SootSprite.collect(item,amount)
	
func playercontains(item):
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false

func amount(item):
	return SootSprite.amount(item)

func size(size):
	SootSprite.size(size)
