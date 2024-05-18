extends Node2D

var player
var anim_p
var markers_group

var world 

#states
var states = [
	"master_butt",
	"slave_butt",
	"item_butt",
	"throw aiming",
	"aiming"
	]

var state = "master_butt"

var action_type


var mas_nr = 0 #number of master buttons -1
var mas_node #which master button is choosen
var choose_m = 0 #number of choosen master button -1

var slav_nr = 0
var slav_options =0
var choose_s = 0



var act_type:String
var action = null
var effect_anim




var marker
var rot_marker = preload("res://Scenes/Combat/Markers/rotate_marker.tscn")
var mov_marker = preload("res://Scenes/Combat/Markers/move_marker.tscn")


var item_choosen
var item_var



#for scroll control
var scroll_y = 0
var scroll_str = 0.3 #dwa przejscia bez scroll back
var scroll_back =0.015

#physical, magic, item
#of button
var skill_type
var phys_index:int
var magic_index:int
var item_index:int


func _ready():
	world = get_parent().get_parent()
	
	markers_group = world.get_node("Markers")
	player = world.get_node("Player")
	
	mas_nr = get_node("MasterButtons").get_child_count() -1
	mas_node = get_node("MasterButtons").get_child(choose_m)
	#get_node("SlaveButtons").visible = false
	
	#slav_nr = get_node("SlaveButtons").get_child_count() -1
	
	anim_p = player.get_node("AnimTreePlayerCombat")
	
	master_butt_change()
	
	$MasterButtons/PhysButton.selection()
	$MasterButtons/MagicButton._ready()
	$MasterButtons/MagicButton.selection()
	
	

func _input(_event):
	#state machine
	#if PlayerInfo.combat_state == "in menu":
	state_machine()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			scroll_y += scroll_str
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			scroll_y -= scroll_str
		
		
func _process(delta):
	scroll_y = move_toward(scroll_y, 0, scroll_back)
	
		
		
func state_machine():
	match state:
		"master_butt": 				
			if Input.is_action_just_pressed("q"):
				scroll_y = 0
				choose_m +=1
				if choose_m > mas_nr:
					choose_m = 0
				master_butt_change()
			
			if scroll_y > 1:
				change_index(1)
				mas_node.selection()
				scroll_y = 0
				
			elif scroll_y < -1:
				change_index(-1)
				mas_node.selection()
				scroll_y = 0
			
			
			if Input.is_action_just_pressed("left_click"):
				set_ability()
				
			
			
			
		
			
		"item_butt": 
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
				
#uzycie na sobie
			elif Input.is_action_just_pressed("f"):
				player.item_on_self(item_choosen.use_on_self)
				PlayerInfo.inv_items[item_var][1] -= 1
				mas_node.selection(choose_s)

				
#rzut, z celowaniem
			elif Input.is_action_just_pressed("r"):
				marker = rot_marker.instantiate()
		
				marker.position = player.position
				marker.rotation.y = player.direction
				marker.get_child(0).scale = Vector3(1,1,1)

				markers_group.add_child(marker)
				
				state = "throw aiming"

		
		"throw aiming":
			get_node("SlaveButtons").visible = false
			get_node("MasterButtons").visible = false
			
			if Input.is_action_just_pressed("q"):
				if markers_group.get_child_count() != 0:
					markers_group.get_child(0).queue_free()
					
				get_node("SlaveButtons").visible = true
				get_node("Aiming").visible = false
				state ="item_butt"
				
				
				
			elif Input.is_action_just_pressed("space"): 
				get_node("SlaveButtons").visible = true
				get_node("Aiming").visible = false
				
				var item = load(item_choosen.throw_pl).instantiate()
				item.item = item_choosen
				world.add_child(item)
				var throw_piv = player.get_node("Model/animNode/ThrowPivot")
				item.global_position = throw_piv.global_position
				item.mov_vec = item.mov_vec.rotated(Vector3(0,1,0), marker.rotation.y)
				#item.rotation.y = markers_group.get_child(0).rotation.y
				
				if markers_group.get_child_count() != 0:
					markers_group.get_child(0).queue_free()
					
				state = "item_butt"

				
				
				
		"aiming":
			#get_node("SlaveButtons").visible = false
			#get_node("MasterButtons").visible = false
			
			if Input.is_action_just_pressed("q"):
				if markers_group.get_child_count() != 0:
					markers_group.get_child(0).queue_free()
					
				#get_node("SlaveButtons").visible = true
				#get_node("Aiming").visible = false
				state ="slave_butt"
				
				
				
				
				
				
			elif Input.is_action_just_pressed("left_click"): 
				#get_node("SlaveButtons").visible = true
				#get_node("Aiming").visible = false

				match action["marker_type"]:
					#functions in them
					"rotate": use_ability_rot()
					"move": use_ability_mov()
					null:use_ability_null()
				



func change_index(amount):
	match skill_type:
		"physical": 
			phys_index += amount
			if phys_index > len(PlayerInfo.phys_skills) -1:
				phys_index = 0
			elif phys_index <0:
				phys_index = len(PlayerInfo.phys_skills) -1
			
			
			
		"magical": 
			magic_index += amount
			if magic_index > $MasterButtons/MagicButton.list_len:
				magic_index = 0
			elif magic_index <0:
				magic_index = $MasterButtons/MagicButton.list_len
				
				
		"item": 
			item_index += amount
			if item_index > len(PlayerInfo.inv_items) -1:
				item_index = 0
			elif item_index <0:
				item_index = len(PlayerInfo.inv_items) -1



#in slave buttons when pressed space
func set_ability(): 
	
	if skill_type == "physical": 
		action = PlayerInfo.phys_skills[phys_index]

				
	elif skill_type == "magical":
		action = PlayerInfo.mag_skills[magic_index]

		
		

	
	effect_anim = action.effect_animation
	get_node("Aiming/Label").text = action.description
	
	#setting marker	
	match action["marker_type"]:
		"rotate": 
			state = "aiming"
			PlayerInfo.combat_state = "in menu"
			marker = rot_marker.instantiate()
			
			#setting all parameters
			marker.position = player.position
			marker.rotation.y = player.direction
			marker.get_child(0).scale = action.marker_size
			marker.get_child(0).position = action.marker_position


			#adding to tree
			markers_group.add_child(marker)
			
		"move":
			state = "aiming"
			PlayerInfo.combat_state = "in menu"
			marker = mov_marker.instantiate()
			
			#setting all parameters
			marker.position = player.position
			marker.get_child(0).scale.x = action.marker_size.x
			marker.get_child(0).scale.z = action.marker_size.z
			marker.get_child(1).scale.x = action.marker_size.x
			marker.get_child(1).scale.y = action.marker_size.y
			marker.get_child(1).scale.z = action.marker_size.z

			marker.max_dis = action.max_distance

			
			#adding to tree
			markers_group.add_child(marker)
			
		"null":

			use_ability_null()







func use_ability_rot():
	player.xz_vec = Vector2(0,0)
	player.velocity = Vector3(0,0,0)
	PlayerInfo.current_hp -= action.self_cost[0]
	PlayerInfo.current_mp -= action.self_cost[1]
	
	effect_anim = effect_anim.instantiate()
	var rotated = action.effect_position.rotated(Vector3(0,1,0), marker.rotation.y)
	effect_anim.position = player.position + rotated
	effect_anim.rotation.y = marker.rotation.y
	effect_anim.action = action


	
	world.add_child(effect_anim)
	
	

	
	player.direction = marker.rotation.y	
	
	marker.delete_self()
	
	anim_p["parameters/Transition/transition_request"] = "Attack"
	anim_p["parameters/Attacks/playback"].start(action["player_animation"])
	
	state = "master_butt"



func use_ability_mov():
	player.xz_vec = Vector2(0,0)
	player.velocity = Vector3(0,0,0)
	PlayerInfo.current_hp -= action.self_cost[0]
	PlayerInfo.current_mp -= action.self_cost[1]
	
	
	effect_anim = effect_anim.instantiate()
	effect_anim.position = marker.position
	effect_anim.action = action

	
	world.add_child(effect_anim)
	
	marker.delete_self()
	state = "master_butt"



func use_ability_null():
	player.xz_vec = Vector2(0,0)
	player.velocity = Vector3(0,0,0)
	PlayerInfo.current_hp -= action.self_cost[0]
	PlayerInfo.current_mp -= action.self_cost[1]
	
	effect_anim = effect_anim.instantiate()
	var rotated = action.effect_position.rotated(Vector3(0,1,0),\
	player.get_node("CameraY").rotation.y)
	effect_anim.position = player.position + rotated
	effect_anim.rotation.y = player.get_node("CameraY").rotation.y + PI
	effect_anim.action = action
	
	player.direction = player.rotation.y	
	
	anim_p["parameters/Transition/transition_request"] = "Attack"
	anim_p["parameters/Attacks/playback"].start(action["player_animation"])

	
	world.add_child(effect_anim)
	
	state = "master_butt"




func master_butt_change():
	mas_node = get_node("MasterButtons").get_child(choose_m)
	skill_type = mas_node.skill_type
	

