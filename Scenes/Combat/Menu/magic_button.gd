extends Node2D


var options = PlayerInfo.mag_skills
var opt_nr = len(options) - 1

var slav_butts

var list
var list_len

func _ready():
	slav_butts = get_parent().get_parent().get_node("SlaveButtons")
	list = []
	for invMag in PlayerInfo.mag_skills.values():
		if invMag != null:
			list.append(invMag)
	list_len = len(list) -1




func activate(button_handler): 
	get_parent().get_parent().slav_options = list_len
	button_handler.state = "slave_butt"

	

func selection(nr):
	slav_butts.get_child(0).get_node("Label").text = list[nr -1 ].name
	slav_butts.get_child(1).get_node("Label").text = list[nr].name
	slav_butts.get_child(2).get_node("Label").text = list[nr - list_len].name
	
