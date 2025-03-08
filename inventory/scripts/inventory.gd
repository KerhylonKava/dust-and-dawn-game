extends Resource

class_name Inventory

signal update
signal updateNum

@export var slots: Array[InvSlot]
#slots = 12
#@export var enough_items = true

func insert(item: InvItem,amount): #adds an item to the inventory
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += amount
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount += amount
	update.emit()

func remove(item: InvItem, amount): #multi remove
	var itemslots = slots.filter(func(slot):return slot.item == item)
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !itemslots.is_empty() and itemslots[0].amount >= amount:
		#enough_items = true
		itemslots[0].amount -= amount
		print("removed ",amount, item.name)
		if itemslots[0].amount <= 0:
			itemslots[0].item = null
			#slot.item = null
			print("slot cleared")
	else:
		if !emptyslots.is_empty() or itemslots[0].amount <= amount:
			#enough_items = false
			print("oh no, not enough ", item.name, "s")
	update.emit()

func amount (item:InvItem): #checks the amount of an item in the inventory
	var itemslots = slots.filter(func(slot): return slot.item == item)
	var emptyslots = slots.filter(func(slot): return slot.item == null)
	if !itemslots.is_empty():
		#print("inv", itemslots[0].amount)
		return itemslots[0].amount
	elif !emptyslots.is_empty():
		#print("inv0")
		return 0


func contains (item:InvItem): #checks if the inventory contains an item
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

"func size(new_size: int):
	 slots.resize(new_size)
	# Create a new properly typed array
	var new_slots: Array[InvSlot] = []
	new_slots.resize(slots.size())
	
	# Fill in slots, replacing nulls with new instances
	for i in range(slots.size()):
		new_slots[i] = slots[i] if slots[i] != null else InvSlot.new()
	"
	
func size(new_size:int):
	slots.resize(new_size)
	var new_slots : Array[InvSlot]
	new_slots.resize(slots.size())
	updateNum.emit()
	for i in range(slots.size()):
		new_slots[i] = slots[i] if slots[i] != null else InvSlot.new()
		if slots[i] == null:
			slots[i] = InvSlot.new()
			print("new", InvSlot)
	slots = new_slots
	print("Slots size set to:", slots.size())
