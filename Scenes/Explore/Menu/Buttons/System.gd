extends Node2D

@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

func activate():
	menu.get_node("MainButtons").visible = false
	menu.get_node("SystemButtons").visible = true
	
	menu.slave_nr = menu.get_node("SystemButtons").get_child_count() -1
	menu.slave_node = menu.get_node("SystemButtons").get_child(0)
	
	menu.state = "system_butt"

