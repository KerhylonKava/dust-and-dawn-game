extends Sprite2D

@export var unlit_lantern : Texture
@export var lit_lantern : Texture
var player = null

# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize the lantern's textures
	unlit_lantern = preload("res://Quest/unlit_lantern.png")
	lit_lantern = preload("res://Quest/lit_lantern.png")
	
	# Start with the unlit lantern texture
	texture = unlit_lantern
	
	# Get the player node and make sure they have collected the light sprite
	player = get_node("/root/1level/SootSprite")  # Adjust this path as needed

# Called every frame
func _process(delta):
	# Check if the player has collected the light sprite and the space key is pressed
	if player.has_collected_light_sprite and Input.is_action_just_pressed("ui_accept"):
		# Switch to the lit lantern when the space key is pressed
		texture = lit_lantern
