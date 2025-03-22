extends Node2D

var SootSprite = null
var player_in_area = false
@onready var l1 = get_parent().get_node("LightingLantern")
@onready var l2 = get_parent().get_node("LightingLantern2")
@onready var b3 = get_parent().get_node("BubbleLantern")
@export var string: InvItem
@export var leaf : InvItem
@export var backpack : InvItem


@onready var scene = get_parent().name

@onready var anim = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")
	$QuestBoards/LanternQuestBoard.visible = false
	$QuestBoards/BackpackQuestBoard.visible = false
	#var lantern = get_parent().get_node("LightingLantern")

func _process(delta):
	if player_in_area:
		$space.visible = true
	elif !player_in_area:
		$space.visible = false
		$QuestBoards.visible = false
	
	if player_in_area and Input.is_action_just_pressed("space"):
		if scene == '1level':
			$QuestBoards/BackpackQuestBoard.visible = true
			if amount(leaf)>=1 and amount(string)>=2: #or playercontains(backpack):
				$QuestBoards/BackpackQuestBoard/All.visible = true
				$QuestBoards/BackpackQuestBoard/Lacking.visible = false
				$QuestBoards.visible = true
				if !playercontains(backpack):
					playerremove(leaf,1)
					playerremove(string,2)
					#playerremove(string)
					playercollect(backpack,1)
					print("backpack made")
					size(12)
				else:
					print("backpack already made")
			elif playercontains(backpack):
				$QuestBoards/BackpackQuestBoard/All.visible = true
				$QuestBoards/BackpackQuestBoard/Lacking.visible = false
				$QuestBoards.visible = true
			else:
				$QuestBoards/BackpackQuestBoard/All.visible = false
				$QuestBoards/BackpackQuestBoard/Lacking.visible = true
				$QuestBoards.visible = true
			#else:
			#	print("player contains function errored")
		if scene == '2level':
			print("2level")
			$QuestBoards.visible =  true
			if l1.lit and l2.lit and b3.lit:
				print("lantern is lit")
				$QuestBoards/LanternQuestBoard/NotLit.visible = false
				$QuestBoards/LanternQuestBoard/Lit.visible = true
				$QuestBoards/LanternQuestBoard.visible = true
			elif !l1.lit and !l2.lit and !b3.lit:
				print("lantern is not lit")
				$QuestBoards/LanternQuestBoard/NotLit.visible = true
				$QuestBoards/LanternQuestBoard/Lit.visible = false
				$QuestBoards/LanternQuestBoard.visible = true
			elif !player_in_area:
				print("bye")
				$QuestBoards.visible = false
	
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body
		#print("player in area")

func playerremove(item,amount):
	SootSprite.remove(item,amount)
	#SootSprite.remove(string)
	#SootSprite.remove(string)

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
	#print("racoon ",item.name,SootSprite.amount(item))
	return SootSprite.amount(item)

func size(size):
	SootSprite.size(size)
