extends Node2D
var player_in_area = false
var SootSprite = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		$Space.visible = true
	else:
		$Space.visible = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		player_in_area = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		SootSprite = body
		player_in_area = false
