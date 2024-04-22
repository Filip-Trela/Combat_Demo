extends Node2D


var options = PlayerInfo.inv_items
var opt_nr = len(options) - 1


var slav_butts


func _ready():
	slav_butts = get_parent().get_parent().get_node("SlaveButtons")


func _process(_delta):
	pass


func activate(button_handler): 
	get_parent().get_parent().slav_options = opt_nr
	button_handler.state = "item_butt"

	
func selection(nr):
	slav_butts.get_child(0).get_node("Label").text = options[nr -1 ][0].name
	slav_butts.get_child(1).get_node("Label").text = options[nr][0].name
	slav_butts.get_child(2).get_node("Label").text = options[nr - opt_nr][0].name
	
	slav_butts.get_child(0).get_node("Amount").text = str(options[nr -1 ][1])
	slav_butts.get_child(1).get_node("Amount").text = str(options[nr][1])
	slav_butts.get_child(2).get_node("Amount").text = str(options[nr - opt_nr][1])


	get_parent().get_parent().item_choosen = options[nr][0]
