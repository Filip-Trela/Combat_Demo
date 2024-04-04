extends Node2D


@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

func activate():
	menu.sub_inventory = PlayerInfo.inv_items
	menu.sub_options = len(PlayerInfo.inv_items) -1
	menu.sub_type = "items"
	
	menu.get_node("InventoryButtons").visible = false
	menu.get_node("ItemsButtons").visible = true
	
	menu.slave_nr = menu.get_node("ItemsButtons").get_child_count() -1
	menu.slave_node = menu.get_node("ItemsButtons").get_child(0)
	
	menu.item_set(0)
	menu.state = "items_butt"

