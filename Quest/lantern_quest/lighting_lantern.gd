extends Sprite2D

@export var unlit_lantern : Texture
@export var lit_lantern : Texture
#var player = null
@export var item: InvItem
#@export var inventory : Inventory;
#@export var inventory = "res://inventory/scripts/inventory.gd"

var SootSprite = null
var player_in_area = false

var is_lantern_lit = false

#var enough_items = SootSprite.enough_items

# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize the lantern's textures
	unlit_lantern = preload("res://Quest/lantern_quest/unlit_lantern.png")
	lit_lantern = preload("res://Quest/lantern_quest/lit_lantern.png")
	
	# Start with the unlit lantern texture
	texture = unlit_lantern
	
	# Get the player node and make sure they have collected the light sprite
	#player = get_node("res://levels/soot_sprite/soot_sprite.gd")  # Adjust this path as needed

# Called every frame
func _process(delta):
	# Check if the player has collected the light sprite and the space key is pressed
	
	
#	if SootSprite.has_collected_light_sprite:
	if player_in_area and Input.is_action_just_pressed("space"):
		# Switch to the lit lantern when the space key is pressed
		if is_lantern_lit == false:
			if playercontains():
				#texture = lit_lantern
				is_lantern_lit = true
				playerremove()
				print("player contains: ", playercontains())
			elif !playercontains():
				print("player contains: ", playercontains())
		else:
			print("lantern is already lit")
	
	if is_lantern_lit == true:
		texture = lit_lantern

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

func playerremove():
	SootSprite.remove(item)

func playercontains():
	if SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return true
	elif !SootSprite.contains(item):
		#print(SootSprite.contains(item))
		return false
