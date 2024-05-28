extends Node2D


func activate():
	var teleporter = get_parent().get_parent().get_parent()
	
	teleporter.get_node("2D_part/MainButtons").visible = false
	teleporter.get_node("2D_part/TeleportButtons").visible = true
	teleporter.slave_nr = teleporter.get_node("2D_part/TeleportButtons").get_child_count() -1
	teleporter.state = "teleport_butt"
	teleporter.teleport_butt_change()
