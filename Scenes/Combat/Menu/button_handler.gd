extends Node2D


#states
var states = [
	"master_butt",
	"slave_butt",
	"in_player"
	]

var state = "master_butt"


var mas_nr = 0 #number of master buttons -1
var mas_node #which master button is choosen
var choose_m = 0 #number of choosen master button -1

var slav_nr = 0
var slav_options =0
var choose_s = 0


var act_type:String
var action:String








func _ready():
	mas_nr = get_node("MasterButtons").get_child_count() -1
	mas_node = get_node("MasterButtons").get_child(choose_m)
	get_node("SlaveButtons").visible = false
	
	slav_nr = get_node("SlaveButtons").get_child_count() -1


func _process(delta):
	pass
	
func _input(event):
	#state machine
	if PlayerInfo.combat_state == "in menu":
		state_machine()
		
		
func state_machine():
	match state:
		"master_butt": 
			if Input.is_action_just_pressed("w"): 
				choose_m -=1
				if choose_m < 0:
					choose_m = mas_nr
				mas_node = get_node("MasterButtons").get_child(choose_m)
				choose_s = 0 #resets slave choose when changed type
				
			elif Input.is_action_just_pressed("s"):
				choose_m +=1
				if choose_m > mas_nr:
					choose_m = 0
				mas_node = get_node("MasterButtons").get_child(choose_m)
				choose_s = 0
			
			elif Input.is_action_just_pressed("space"):
				mas_node.activate()
				get_node("MasterButtons").visible = false
				get_node("SlaveButtons").visible = true
				mas_node.selection(choose_s)
				state = "slave_butt"
			
			
			
		"slave_butt": 
			if Input.is_action_just_pressed("w"): 
				choose_s -=1
				if choose_s < 0:
					choose_s = slav_options
				mas_node.selection(choose_s)
				
			elif Input.is_action_just_pressed("s"):
				choose_s +=1
				if choose_s > slav_options:
					choose_s = 0
				mas_node.selection(choose_s)

				
			elif Input.is_action_just_pressed("q"):
				get_node("MasterButtons").visible = true
				get_node("SlaveButtons").visible = false
				state = "master_butt"
				
			elif Input.is_action_just_pressed("space"):
				act_type = get_node("MasterButtons").get_child(choose_m).name
				action = get_node("SlaveButtons/Button2/Label").text
				print(act_type)
				
				
				state = "in_player"
				
				
				
		"in_player":
			if Input.is_action_just_pressed("q"):
				state ="slave_butt"
		
