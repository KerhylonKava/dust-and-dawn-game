extends Camera2D

var is_open = false
#@onready var help_sign = get_node("res://Quest/help_sign.tscn")
@onready var help_sign = get_node("../../HelpSign")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if help_sign:  # Check if the node exists
		help_sign.help.connect(disable)
		help_sign.helpend.connect(enable)
	else:
		print("help_sign is null! Check the path or if it's loaded.")
	#help_sign.help.connect(zoom_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open == false:
			is_open = true
			position.y -= 200
			position_smoothing_speed -= 1
		else:
			is_open = false
			position.y += 200
			position_smoothing_speed += 1

func disable():
	enabled = false

func enable():
	enabled = true
