extends Node2D

@export var item: InvItem

var SootSprite = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SootSprite = $SootSprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	if Input.is_action_pressed("space"):
		drop_lantern()

##on area 2d get overlaping areas/bodys then check nodepaths
#$CollisionShape2D.input_event.connect(handle_input)

func drop_lantern():
	SootSprite.collect(item)
