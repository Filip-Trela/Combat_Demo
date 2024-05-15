extends StaticBody3D

# 4 is figure, 2 is weapon, 1 is item
@export_flags("item", "weapon", "figure", "magic") var type
@export var id = 0

func interact():
	match type:
		1: #item
			PlayerInfo.add_item(InventoryInfo.find_item(id))
		2:
			PlayerInfo.add_weapon(InventoryInfo.find_weapon(id))
		4:
			PlayerInfo.add_armor(InventoryInfo.find_armor(id))
		8:
			PlayerInfo.add_magic(Actions.find_magic(id))
	queue_free()
