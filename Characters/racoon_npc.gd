extends Node2D

var SootSprite = null
var player_in_area = false
@onready var lantern = get_parent().get_node("LightingLantern")
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
			$QuestBoards/BackpackQuestBoard.visible =  true
			if playercontains(leaf) and playercontains(string): #or playercontains(backpack):
				$QuestBoards/BackpackQuestBoard/All.visible = true
				$QuestBoards/BackpackQuestBoard/Lacking.visible = false
				$QuestBoards.visible = true
				if !playercontains(backpack):
					playerremove(leaf)
					playerremove(string)
					playercollect(backpack)
					print("backpack made")
			elif playercontains(backpack):
				$QuestBoards/BackpackQuestBoard/All.visible = true
				$QuestBoards/BackpackQuestBoard/Lacking.visible = false
				$QuestBoards.visible = true
				print("backpack already made")
			else:
				$QuestBoards/BackpackQuestBoard/All.visible = false
				$QuestBoards/BackpackQuestBoard/Lacking.visible = true
				$QuestBoards.visible = true
			#else:
			#	print("player contains function errored")
		elif scene == '2level':
			$QuestBoards/LanternQuestBoard.visible =  true
			if lantern.is_lantern_lit == true:
				$LanternQuestBoard/NotLit.visible = false
				$LanternQuestBoard/Lit.visible = true
				$LanternQuestBoard.visible = true
			elif lantern.is_lantern_lit == false:
				$LanternQuestBoard/NotLit.visible = true
				$LanternQuestBoard/Lit.visible = false
				$LanternQuestBoard.visible = true
			elif !player_in_area:
				$LanternQuestBoard.visible = false
	
	"""
	if $QuestBoards/BackpackQuestBoard/All.visible:
		if $QuestBoards.visible:
			if Input.is_action_just_pressed("space"):
				playerremove(leaf)
				playerremove(string)
				playercollect(backpack)
				print("backpack made")
			"""
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

func playerremove(item):
	SootSprite.remove(item)
	#SootSprite.remove(string)
	#SootSprite.remove(string)

func playercollect(item):
	SootSprite.collect(item)
	
func playercontains(item):
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false
