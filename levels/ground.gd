extends Node

var SootSprite = null
var player_in_area = false

@export var area_num = null

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#$TileMapLayer.enabled = true
	#$TileMapLayer2.enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		area_num = 2
	if area_num == 2:
		$TileMapLayer.enabled = false
		$TileMapLayer2.enabled = true

	if Input.is_action_pressed("test"):
		area_num = 2





func _on_area_2d_body_entered(body: CollisionShape2D) -> void:
	if body.has_method("soot_sprite"):
		area_num = 2
		player_in_area = true
		SootSprite = body
		print("hello")
