extends Node2D




var states = ["main_butt",
	"inventory_butt",
	"invsub_butt",
	"system_butt",
	"items_butt"

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




func _ready():
	self.visible = false
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
		
		"inventory_butt": 
			if Input.is_action_just_pressed("w"):
				choose_s  -=1
				if choose_s < 0:
					choose_s = slave_nr
				slave_node = $InventoryButtons.get_child(choose_s)
				
			elif Input.is_action_just_pressed("s"):
				choose_s  +=1
				if choose_s > slave_nr:
					choose_s =0 
				slave_node = $InventoryButtons.get_child(choose_s)
			
			elif Input.is_action_just_pressed("space"): 
				sub_nr = $InventorySubButtons.get_child_count() -1
				slave_node.activate()
			
			elif Input.is_action_just_pressed("q"):
				slave_nr = 0
				slave_node = null
				choose_s = 0
				$InventoryButtons.visible = false
				$MainButtons.visible = true
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
				sub_nr = 0
				sub_node = null
				choose_sub = 0
				$InventorySubButtons.visible = false
				$InventoryButtons.visible = true
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
				$ItemsButtons.visible = false
				$InventoryButtons.visible = true
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
				slave_nr = 0
				slave_node = null
				choose_s = 0
				$SystemButtons.visible = false
				$MainButtons.visible = true
				state = "main_butt"


func main_butt_change():
	mas_node = $MainButtons.get_child(choose_m)

func sub_inventory_set(nr):
		
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
