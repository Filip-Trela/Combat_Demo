extends Node2D




var states = ["main_butt"

]
var state = "main_butt"

var mas_nr = 0 #number of master buttons -1
var mas_node #which master button is choosen
var choose_m = 0 #number of choosen master button -1



func _ready():
	mas_nr = $MainButtons.get_child_count() -1
	main_butt_change()
	#setting colors
	$Background["modulate"] = PlayerInfo.color_sex
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerInfo.explore_state == "menu":
		state_machine()

func state_machine():
	match state:
		"main_butt":
			if Input.is_action_just_pressed("w"):
				choose_m  -=1
				if choose_m < 0:
					choose_m = mas_nr
				main_butt_change()
				
			elif Input.is_action_just_pressed("s"):
				choose_m  +=1
				if choose_m > mas_nr:
					choose_m =0 
				main_butt_change() 
				
			elif Input.is_action_just_pressed("space"): 
				mas_node.activate()
		
		
		


func main_butt_change():
	mas_node = $MainButtons.get_child(choose_m)
