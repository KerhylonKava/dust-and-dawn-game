extends Sprite2D


@export var unlit_lantern : Texture
@export var lit_lantern : Texture
#var player = null
@export var light: InvItem
@export var cave_key : InvItem
#@export var inventory : Inventory;
#@export var inventory = "res://inventory/scripts/inventory.gd"
@onready var LightingLantern_Sound = $LightingLantern_Sound
@onready var SootSprite = get_parent().get_node("SootSprite")
var player_in_area = false

var lit = false

#var enough_items = SootSprite.enough_items

# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize the lantern's textures
	#unlit_lantern = preload("res://Quest/lantern_quest/unlit_lantern.png")
	#lit_lantern = preload("res://Quest/lantern_quest/lit_lantern.png")
	
	# Start with the unlit lantern texture
	if amount(cave_key)>=1:
		lit = true
		texture = lit_lantern
	else:
		lit= false
		texture = unlit_lantern
	
	# Get the player node and make sure they have collected the light sprite
	#player = get_node("res://levels/soot_sprite/soot_sprite.gd")  # Adjust this path as needed

# Called every frame
func _process(delta):
	if player_in_area:
		if amount(light) >= 3:
				$Node2D/space.visible = true
				if Input.is_action_just_pressed("space"):
					if lit == false:
						lit = true
						LightingLantern_Sound.play()
						playerremove(light,3)
					else:
						print("lantern is already lit")
		elif !amount(light) >= 3:
				$Node2D/space.visible = false
	elif !player_in_area:
		$Node2D/space.visible = false
	# Check if the player has collected the light sprite and the space key is pressed
	
	"""
#	if SootSprite.has_collected_light_sprite:
	if player_in_area:
		if amount(light) >= 3:
			
		Input.is_action_just_pressed("space"):
		# Switch to the lit lantern when the space key is pressed
		if is_lantern_lit == false:
			if amount(light) >= 3:
				#texture = lit_lantern
				is_lantern_lit = true
				LightingLantern_Sound.play()
				playerremove(light,3)
				#print("player contains: ", playercontains(light,5))
			elif !amount(light) >= 3:
				#print("player contains: ", playercontains(light,5))
				pass
		else:
			print("lantern is already lit")
	"""
	if lit == true:
		texture = lit_lantern

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("soot_sprite"):
		player_in_area = true
		SootSprite = body

func playerremove(item,amount):
	SootSprite.remove(item,amount)

func amount(item):
	#print("racoon ",item.name,SootSprite.amount(item))
	return SootSprite.amount(item)
