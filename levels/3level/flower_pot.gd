extends Node2D

@export var water : InvItem

@export var stage1 : Texture
@export var stage2 : Texture
@export var stage3 : Texture
@export var stage4 : Texture
@onready var stage = 1
var growtime = 50

var player_in_area = false
var SootSprite = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = stage1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		if playercontains(water):
			$popup.visible = true
			if Input.is_action_just_pressed("space"):
				if stage <= 4:
					grow()
					playerremove(water,1)
		elif !playercontains(water):
			$popup.visible = false
	elif !player_in_area:
		$popup.visible = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false
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

func grow():
	stage += 1
	if $Sprite2D.texture == stage1:
		$Sprite2D.texture = stage2
	elif $Sprite2D.texture == stage2:
		$Sprite2D.texture = stage3
	elif $Sprite2D.texture == stage3:
		$Sprite2D.texture = stage4
