extends Resource

class_name Inventory

signal update

@export var slots: Array[InvSlot]
#@export var enough_items = true

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func remove(item: InvItem):
	var itemslots = slots.filter(func(slot):return slot.item == item)
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !itemslots.is_empty() and itemslots[0].amount >= 1:
		#enough_items = true
		itemslots[0].amount -= 1
		print("removed")
		if itemslots[0].amount <= 0:
			itemslots[0].item = null
			#slot.item = null
			print("slot cleared")
	else:
		if !emptyslots.is_empty():
			#enough_items = false
			print("oh no, not enough ", item.name, "s")
	update.emit()

func contains (item:InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !itemslots.is_empty():
		#print("true")
		return true
	elif !emptyslots.is_empty():
		#print("false")
		return false
	else:
		print("oh no, contains function has errored out")
