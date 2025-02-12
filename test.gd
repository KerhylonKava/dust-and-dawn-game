extends Node2D

@export var item: InvItem

var SootSprite = null
var player_in_area = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SootSprite = $SootSprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("space"):
			drop_lantern()
	

##on area 2d get overlaping areas/bodys then check nodepaths
#$CollisionShape2D.input_event.connect(handle_input)

func drop_lantern():
	print("lantern")
	SootSprite.collect(item)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false
