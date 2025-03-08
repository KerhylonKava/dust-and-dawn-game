extends Control

@onready var inventory : Inventory = preload("res://inventory/scripts/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	inventory.update.connect(update_slots)
	inventory.updateNum.connect(change_num_slots)
	update_slots()
	close()

func update_slots():
	for i in range (min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func change_num_slots():
	var visible_count = $NinePatchRect/GridContainer.get_children().filter(func(c): return c.visible).size()
	print("Visible slots:", visible_count)
	#var child_count = get_child_count()
	if visible_count > inventory.slots.size():
		for i in range(visible_count - inventory.slots.size()):
			hide_last_visible_child()
	if visible_count < inventory.slots.size():
		for i in range(inventory.slots.size() - visible_count):
			show_first_hidden_child()



func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()


func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false

func hide_last_visible_child():
	for i in range($NinePatchRect/GridContainer.get_child_count() -1, -1, -1):
		var child=$NinePatchRect/GridContainer.get_child(i)
		if child.has_method("set_visible") and child.visible:
			child.visible = false
			print("hid child", child.name)
			break

func show_first_hidden_child():
	for i in range($NinePatchRect/GridContainer.get_child_count() -1, -1, -1):
		var child=$NinePatchRect/GridContainer.get_child(i)
		if child.has_method("set_visible") and !child.visible:
			child.visible = true
			print("show child", child.name)
			break
