extends Node2D

var SootSprite = null
var player_in_area = false

signal help
signal helpend

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.enabled = false
	$I.visible = false
	$Chest.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		$space.visible = true
	elif !player_in_area:
		$space.visible = false
		helpend.emit()
		$Camera2D.enabled = false
		$help.visible = true
		$I.visible = false
		$Chest.visible = false
	
	if Input.is_action_just_pressed("space") and player_in_area:
		if $Camera2D.enabled == false:
			help.emit()
			$Camera2D.enabled = true
			$help.visible = false
			$I.visible = true
			$Chest.visible = true
		else:
			helpend.emit()
			$Camera2D.enabled = false
			$help.visible = true
			$I.visible = false
			$Chest.visible = false

		
