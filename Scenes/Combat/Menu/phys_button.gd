extends Node2D


var options = PlayerInfo.phys_skills
var opt_nr = len(options) - 1

var slav_butts


func _ready():
	slav_butts = get_parent().get_parent().get_node("SlaveButtons")


func _process(delta):
	pass


func activate(): 
	get_parent().get_parent().slav_options = opt_nr
	print("physical")
	
func selection(nr):
	slav_butts.get_child(0).get_node("Label").text = options[nr -1 ]
	slav_butts.get_child(1).get_node("Label").text = options[nr]
	slav_butts.get_child(2).get_node("Label").text = options[nr - opt_nr]
