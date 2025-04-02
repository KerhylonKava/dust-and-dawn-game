extends Node2D

var SootSprite = null
var player_in_area = false
@export var crystal : InvItem
@export var GlowCrystal : InvItem

@onready var scene = get_parent().name
@onready var animated_sprite_2d = $"Animated Sprite"
#@onready var anim = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$QuestBoards/GolemQuestBoard.visible = false
	animated_sprite_2d.play("default")


func _process(delta):
	if player_in_area:
		$space.visible = true
	elif !player_in_area:
		$space.visible = false
		$QuestBoards.visible = false
	
	if player_in_area and Input.is_action_just_pressed("space"):
		print("space")
		if scene == '4level':
			$QuestBoards/GolemQuestBoard.visible =  true
			if amount(crystal)>=10 and amount(GlowCrystal)<=0: 
				$QuestBoards/GolemQuestBoard/NotFixed.visible = false
				$QuestBoards/GolemQuestBoard/Fixed.visible = true
				$QuestBoards.visible = true
				print("true")
				playerremove(crystal, 10)
				playercollect(GlowCrystal, 1)
			elif amount(GlowCrystal)>=1:
				$QuestBoards/GolemQuestBoard/NotFixed.visible = false
				$QuestBoards/GolemQuestBoard/Fixed.visible = true
				$QuestBoards.visible = true
			else:
				$QuestBoards/GolemQuestBoard/NotFixed.visible = true
				$QuestBoards/GolemQuestBoard/Fixed.visible = false
				$QuestBoards.visible = true
				print("false")
				#playercollect(crystal,10) #cheat for testing


	
	
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
