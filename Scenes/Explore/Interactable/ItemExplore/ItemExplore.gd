extends StaticBody3D

# 4 is figure, 2 is weapon, 1 is item
@export_flags("item", "weapon", "figure") var type
@export var id = 0

func interact():
	if type == 1:
		PlayerInfo.add_item(InventoryInfo.find_item(id))
	elif type == 2:
		PlayerInfo.inv_weapons.append(InventoryInfo.find_weapon(id))
	elif type == 4:
		PlayerInfo.inv_figures.append(InventoryInfo.find_figure(id))
		
	queue_free()
