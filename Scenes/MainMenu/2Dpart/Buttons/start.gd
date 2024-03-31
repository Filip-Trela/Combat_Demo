extends Node2D




var menu
var main_butt
var start_butt

func _ready(): 
	menu = get_parent().get_parent()
	main_butt = get_parent()
	start_butt =get_parent().get_parent().get_node("StartButtons")

	
func activate(): 
	#invisible main buttons
	menu.start_butt_change(0)
	menu.slave_nr = start_butt.get_child_count() -1
	main_butt.visible = false
	start_butt.visible = true
	
	menu.state = "start_butt"
	
