extends Button

@export var aging_amount_on_press = 1.0
@export var water : InvItem
@onready var SootSprite = get_parent().get_parent().get_node("SootSprite")

func _ready() -> void:
	visible = false
	connect("pressed", _on_pressed)
	
func _process(float) -> void:
	if playercontains(water):
		visible = true
	else:
		visible = false
	
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

func _on_pressed():
	playerremove(water , 1)
	for aging_component in get_tree().get_nodes_in_group(AgingComponent.group_name):
		if(aging_component is AgingComponent):
			aging_component.current_age += aging_amount_on_press
		else:
			push_error(aging_component.name + "node is not an AgingComponent")
