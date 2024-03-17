extends Node2D

var player
var markers_group


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
var action_name:String
var action = null


var marker
var rot_marker = preload("res://Scenes/Combat/Markers/rotate_marker.tscn")
var mov_marker = preload("res://Scenes/Combat/Markers/move_marker.tscn")





func _ready():
	player = get_parent().get_parent().get_node("World/Player")
	markers_group = get_parent().get_parent().get_node("World/Markers")
	
	mas_nr = get_node("MasterButtons").get_child_count() -1
	mas_node = get_node("MasterButtons").get_child(choose_m)
	get_node("SlaveButtons").visible = false
	
	slav_nr = get_node("SlaveButtons").get_child_count() -1



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
				set_ability()
				
				state = "in_player"
				
				
				
		"in_player":
			if Input.is_action_just_pressed("q"):
				if markers_group.get_child_count() != 0:
					if action.marker_type ==  "move":
						marker.delete_self()

					markers_group.get_child(0).queue_free()
				state ="slave_butt"
				
				
				
				
				
				
			elif Input.is_action_just_pressed("space"): 
				match action["marker_type"]:
					#functions in them
					"rotate": use_ability_rot()
					"move": use_ability_mov()
					null:use_ability_null()













#in slave buttons when pressed space
func set_ability(): 
	act_type = get_node("MasterButtons").get_child(choose_m).name
	action_name = get_node("SlaveButtons/Button2/Label").text
	
	if act_type == "PhysButton": 
		action = PlayerInfo.phys_skills[choose_s]
				
	elif act_type == "MagicButton":
		action = PlayerInfo.mag_skills[choose_s]
		
		
		#setting marker
	
	
	match action["marker_type"]:
		"rotate": 
			marker = rot_marker.instantiate()
			
			#setting all parameters
			marker.position = player.position
			marker.rotation.y = player.direction
			marker.get_child(0).scale = action.marker_size
			marker.get_child(0).position = action.marker_position


			#adding to tree
			markers_group.add_child(marker)
			
		"move":
			marker = mov_marker.instantiate()
			
			#setting all parameters
			marker.position = player.position
			marker.get_child(0).scale = action.marker_size
			marker.get_child(1).scale = action.marker_size
			marker.get_child(1).scale.y = 1
			marker.max_dis = action.max_distance
			
			marker.get_node("CameraY/CameraX/Camera3D").current = true
			marker.get_node("CameraY").rotation.y = player.mouse_joint_y.rotation.y
			marker.get_node("CameraY/CameraX").rotation.x = player.mouse_joint_x.rotation.x
			
			#adding to tree
			markers_group.add_child(marker)
			
			
		null:pass
		
		
func use_ability_rot():print("rotate")

func use_ability_mov():print("move")

func use_ability_null():print("null")
