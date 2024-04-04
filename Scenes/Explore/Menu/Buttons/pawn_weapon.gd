extends Node2D


@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

func activate():
	menu.sub_inventory = PlayerInfo.inv_weapons
	menu.sub_options = len(PlayerInfo.inv_weapons) -1
	menu.sub_type = "weapons"
	
	menu.get_node("InventoryButtons").visible = false
	menu.get_node("InventorySubButtons").visible = true
	menu.sub_inventory_set(0)
	menu.state = "invsub_butt"
