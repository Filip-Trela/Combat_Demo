extends Node2D


var options = PlayerInfo.mag_skills
var opt_nr = len(options) - 1

var slav_butts

var list
var list_len

var skill_type = "magical"

func _ready():
	#slav_butts = get_parent().get_parent().get_node("SlaveButtons")
	list = []
	for invMag in PlayerInfo.mag_skills.values():
		if invMag != null:
			list.append(invMag)
	list_len = len(list) -1





func activate(button_handler): 
	get_parent().get_parent().set_ability()

func second_activate(): pass

func selection():
	
	var index = get_parent().get_parent().magic_index

	$Buttons/Label1.text = list[index -1 ].name
	$Buttons/Label2.text = list[index].name
	$Buttons/Label3.text = list[index - list_len].name
	
