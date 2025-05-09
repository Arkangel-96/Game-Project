extends Area2D

signal item_added(item:Item, quantity:int)
signal item_consumed(item_type:Item.ItemType, quantity_left:int)

var inventory = {} ## ESENCIAL ##

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area is Item:
		add_item_to_inventory(area)
		area.collect_item()	

func add_item_to_inventory(item: Item):
	if not inventory.has(item.type):
		inventory[item.type] = 1
	else:
		inventory[item.type] = inventory[item.type] + 1
	item_added.emit(item, inventory[item.type])
	prints("Has recogido el objeto de tipo", Item.ItemType.keys()[item.type], "ahora tienes:", inventory[item.type])

func consume_item_from_inventory(item_type:Item.ItemType):
	if inventory.has(item_type):
		inventory[item_type] = inventory[item_type] - 1
		item_consumed.emit(item_type, inventory[item_type])
		prints("Has consumido el objeto de tipo", Item.ItemType.keys()[item_type], "ahora tienes:", inventory[item_type])
		if inventory[item_type] <=0: inventory.erase(item_type)


func _on_inventory_ui_inventory_item_ui_selected(item_type: Item.ItemType) -> void:
	consume_item_from_inventory(item_type)
