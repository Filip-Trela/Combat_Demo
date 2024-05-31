extends Node2D


var options = PlayerInfo.phys_skills
var opt_nr = len(options) - 1


var slav_butts
var skill_type = "physical"

var player


func _ready():
	pass#player = get_parent().get_parent().get_parent().get_parent().get_node("Player")


func _process(_delta):
	pass


func activate(button_handler): 
	button_handler.set_ability()

func second_activate(): pass
	
func selection():

	
	options = PlayerInfo.phys_skills
	opt_nr = len(options) - 1
	var index = get_parent().get_parent().phys_index
	
	$Buttons/Name1/Label1.text = options[index -1 ].name
	$Buttons/Name2/Label2.text = options[index].name
	$Buttons/Name3/Label3.text = options[index - opt_nr].name

