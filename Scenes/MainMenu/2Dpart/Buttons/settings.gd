extends Node2D



var menu
var main_butt
var settin_butt

func _ready(): 
	menu = get_parent().get_parent()
	main_butt = get_parent()
	settin_butt =get_parent().get_parent().get_node("SettingButtons")

	
func activate(): 
	#invisible main buttons
	menu.set_butt_change(0)
	menu.slave_nr = settin_butt.get_child_count() -1
	main_butt.visible = false
	settin_butt.visible = true
	
	menu.state = "set_butt"
	
