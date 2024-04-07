extends Node2D


@onready var anim = $AnimationTree

var states = ["main_butt",
	"inventory_butt",
	"invsub_butt",
	"system_butt",
	"items_butt",
	"magic_butt",
	"magsub_butt"

]
var state = "main_butt"

var mas_nr = 0 #number of master buttons -1
var mas_node #which master button is choosen
var choose_m = 0 #number of choosen master button -1

var slave_nr = 0
var slave_node
var choose_s = 0

var sub_nr = 0
var sub_node
var choose_sub = 0

#weapons, items or figures
var sub_inventory
var sub_options = 0
var sub_type


#magic slot means position in playerinfo.magskills
var magic_slot = 0


func _ready():
	#self.visible = false
	mas_nr = $MainButtons.get_child_count() -1
	main_butt_change()
	#setting colors
	#$Background["modulate"] = PlayerInfo.color_sex
	


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
		
		"inventory_butt": 
			if Input.is_action_just_pressed("w"):
				choose_s  -=1
				if choose_s < 0:
					choose_s = slave_nr
				inv_butt_change()
				
				
			elif Input.is_action_just_pressed("s"):
				choose_s  +=1
				if choose_s > slave_nr:
					choose_s =0 
				inv_butt_change()
			
			elif Input.is_action_just_pressed("space"): 
				anim.pawn_to_pawnsub()
				sub_nr = $InventorySubButtons.get_child_count() -1
				slave_node.activate()
			
			elif Input.is_action_just_pressed("q"):
				anim.pawn_to_main()
				slave_nr = 0
				slave_node = null
				choose_s = 0

				state = "main_butt"
		
		"invsub_butt":
			if Input.is_action_just_pressed("w"):
				choose_sub  -=1
				if choose_sub < 0:
					choose_sub = sub_options
				sub_inventory_set(choose_sub)
				
			elif Input.is_action_just_pressed("s"):
				choose_sub  +=1
				if choose_sub > sub_options:
					choose_sub =0 
				sub_inventory_set(choose_sub)
			
			elif Input.is_action_just_pressed("space"): 
				if sub_type == "figures": 
					PlayerInfo.current_figure = PlayerInfo.inv_figures[choose_sub]
				elif sub_type == "weapons":
					PlayerInfo.current_weapon = PlayerInfo.inv_weapons[choose_sub]
			
			elif Input.is_action_just_pressed("q"):
				anim.pawnsub_to_pawn()
				sub_nr = 0
				sub_node = null
				choose_sub = 0
				state = "inventory_butt"
			
		"items_butt":
			if Input.is_action_just_pressed("w"):
				choose_sub  -=1
				if choose_sub < 0:
					choose_sub = sub_options
				item_set(choose_sub)
				
			elif Input.is_action_just_pressed("s"):
				choose_sub  +=1
				if choose_sub > sub_options:
					choose_sub =0 
				item_set(choose_sub)
			
			elif Input.is_action_just_pressed("space"): 
				pass
			
			elif Input.is_action_just_pressed("q"):
				sub_nr = 0
				sub_node = null
				choose_sub = 0

				state = "inventory_butt"
			
		"system_butt":
			if Input.is_action_just_pressed("w"):
				choose_s  -=1
				if choose_s < 0:
					choose_s = slave_nr
				slave_node = $SystemButtons.get_child(choose_s)
				
			elif Input.is_action_just_pressed("s"):
				choose_s  +=1
				if choose_s > slave_nr:
					choose_s =0 
				slave_node = $SystemButtons.get_child(choose_s)
			
			elif Input.is_action_just_pressed("space"): 
				slave_node.activate()
			
			elif Input.is_action_just_pressed("q"):
				anim.system_to_main()
				slave_nr = 0
				slave_node = null
				choose_s = 0
				state = "main_butt"

		"magic_butt":
			if Input.is_action_just_pressed("w"):
				choose_s  -=1
				if choose_s < 0:
					choose_s = slave_nr
				magic_slot_set(choose_s)
				
			elif Input.is_action_just_pressed("s"):
				choose_s  +=1
				if choose_s > slave_nr:
					choose_s =0 
				magic_slot_set(choose_s)
			
			elif Input.is_action_just_pressed("space"): 
				var list = magic_list_set(0)
				if list != []:
					anim.magic_to_magicsub()
					magic_slot = choose_s +1

					sub_options = len(list) -1
					state = "magsub_butt"
			
			elif Input.is_action_just_pressed("q"):
				anim.magic_to_main()
				slave_nr = 0
				slave_node = null
				choose_s = 0
				state = "main_butt"
		
		"magsub_butt":
			if Input.is_action_just_pressed("w"):
				choose_sub  -=1
				if choose_sub < 0:
					choose_sub = sub_options
				magic_list_set(choose_sub)
				
			elif Input.is_action_just_pressed("s"):
				choose_sub  +=1
				if choose_sub > sub_options:
					choose_sub =0 
				magic_list_set(choose_sub)
			
			elif Input.is_action_just_pressed("space"): 
				magic_option_set(choose_sub)
				
				sub_nr = 0
				sub_node = null
				choose_sub = 0
				state = "magic_butt"
			
			elif Input.is_action_just_pressed("q"):
				anim.magicsub_to_magic()
				sub_nr = 0
				sub_node = null
				choose_sub = 0
				state = "magic_butt"




func main_butt_change():
	#$MainButtons.get_child(choose_m - 1).scale(Vector2(1,1))
	#$MainButtons.get_child(choose_m).scale(Vector2(1.2,1.2))
	#$MainButtons.get_child(choose_m -3).scale(Vector2(1,1))
	mas_node = $MainButtons.get_child(choose_m)

func inv_butt_change():
	#$InventoryButtons.get_child(choose_s - 1).scale(Vector2(1,1))
	#$InventoryButtons.get_child(choose_s).scale(Vector2(1.2,1.2))
	#$InventoryButtons.get_child(choose_s -3).scale(Vector2(1,1))
	
	slave_node = $InventoryButtons.get_child(choose_s)

func sub_inventory_set(nr):
	#$InventorySubButtons.get_child(1).scale(Vector2(1.2,1.2))
		
	$InventorySubButtons.get_child(0).get_node("Label").text = sub_inventory[nr-1].name
	$InventorySubButtons.get_child(1).get_node("Label").text = sub_inventory[nr].name
	$InventorySubButtons.get_child(2).get_node("Label").text = sub_inventory[nr-sub_options].name


func item_set(nr):
	
	#setting names for buttons
	$ItemsButtons.get_child(0).get_node("Label").text = sub_inventory[nr-1][0].name
	$ItemsButtons.get_child(1).get_node("Label").text = sub_inventory[nr][0].name
	$ItemsButtons.get_child(2).get_node("Label").text = sub_inventory[nr-sub_options][0].name
	
	#setting number of items
	$ItemsButtons.get_child(0).get_node("Amount").text = str(sub_inventory[nr-1][1])
	$ItemsButtons.get_child(1).get_node("Amount").text = str(sub_inventory[nr][1])
	$ItemsButtons.get_child(2).get_node("Amount").text = str(sub_inventory[nr-sub_options][1])

func magic_slot_set(nr):
	#TODO change later
	pass#rint($MagicButtons.get_child(nr).get_node("Label").text)
	
func magic_list_set(nr):
	var list = []
	for invMag in PlayerInfo.inv_magic:
		if invMag in PlayerInfo.mag_skills.values():
			pass
		else:
			list.append(invMag)
	var list_len = len(list) -1
	if list != []:
		$MagicSubButtons.get_child(0).get_node("Label").text = list[nr-1].name
		$MagicSubButtons.get_child(1).get_node("Label").text = list[nr].name
		$MagicSubButtons.get_child(2).get_node("Label").text = list[nr-list_len].name
	return list

func magic_option_set(nr):
	var list = []
	for invMag in PlayerInfo.inv_magic:
		if invMag in PlayerInfo.mag_skills.values():
			pass
		else:
			list.append(invMag)
	var list_len = len(list) -1
	PlayerInfo.mag_skills[magic_slot] = list[nr]
