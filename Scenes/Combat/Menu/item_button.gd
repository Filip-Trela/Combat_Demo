extends Node2D


var options = PlayerInfo.inv_items
var opt_nr = len(options) - 1
var index

var slav_butts

var skill_type = "item"


func _ready():
	slav_butts = get_parent().get_parent().get_node("SlaveButtons")


func _process(_delta):
	pass


func activate(button_handler): 
	button_handler.state = "item_set"
	#get_parent().get_parent().slav_options = opt_nr
	#button_handler.state = "item_butt"

#uzycie na sobie
func second_activate(): 
	var player = get_parent().get_parent().player
	player.item_on_self(options[index][0].use_on_self)
	PlayerInfo.inv_items[index][1] -= 1
	selection()

	
func selection():
	index = get_parent().get_parent().item_index
	
	$Buttons/Label1.text = options[index -1 ][0].name
	$Buttons/Label2.text = options[index][0].name
	$Buttons/Label3.text = options[index - opt_nr][0].name
	
	#slav_butts.get_child(0).get_node("Amount").text = str(options[nr -1 ][1])
	$Amount.text = str(options[index][1])
	#slav_butts.get_child(2).get_node("Amount").text = str(options[nr - opt_nr][1])

	get_parent().get_parent().item_choosen = options[index][0]
