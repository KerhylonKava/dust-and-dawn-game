extends Button

@export var aging_amount_on_press = 1.0

func _ready() -> void:
	connect("pressed", _on_pressed)


func _on_pressed():
	for aging_component in get_tree().get_nodes_in_group(AgingComponent.group_name):
		if(aging_component is AgingComponent):
			aging_component.current_age += aging_amount_on_press
		else:
			push_error(aging_component.name + "node is not an AgingComponent")
