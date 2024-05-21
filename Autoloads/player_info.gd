extends Node

var transition



#combat variables
var action_list = Actions
var inv_list = InventoryInfo




#male, female
var sex:String
var color_sex
var color_sex_sec
var color_sex_trd
var neutral_color = Color(0.0, 0.0, 0.0, 0.0) #?????

#change secondary colors later
var female_color = Color(0.851, 0.412, 0.886, 1.0) 
var female_color_sec = Color(0.777, 0.271, 0.882, 1.0) 
var female_color_trd = Color(0.969, 0.435, 0.592, 1.0)
var male_color = Color(0.0, 0.875, 0.518, 1.0)
var male_color_sec = Color(0.0, 0.776, 0.533, 1.0)
var male_color_trd = Color(0.263, 0.776, 0.718, 1.0)



#MORE OF A GLOBAL AUTOLOAD
var is_moving = false
# "moving" , "in menu" , "during action", "dead
var combat_state = "moving"

var follows = 0
var follows_max = 3

var during_follows = false

#moving, menu, talking, attacking
var explore_state = "moving"




var phys_skills = [
	action_list.slash,
	action_list.vertical_slash,
	action_list.multislash
]


var mag_skills= {
	0: action_list.placeH,
	1: action_list.push,
	2: null,
	3: null
}

var inv_magic = [
	action_list.placeH
]

var inv_armor = [
	inv_list.basearmor,

]


var inv_weapons = [
	inv_list.katana,
	inv_list.canon
]

var inv_items = [
	[inv_list.heal_potion, 3],
	[inv_list.magic_potion, 15],
	[inv_list.base_item, 1],
	[inv_list.knife, 10],

]


#PLAYER STATS
var max_hp:int = 100
var current_hp:int = max_hp

var max_mp:int = 100
var current_mp:int = max_mp

var max_sp:float = 100
var current_sp:float = max_sp
var sp_recovery_min = 0.05
var sp_recovery_max = 0.5
var sp_recovery_change = 0.01
var sp_recovery = 0
var sp_time_rec = 1.0

var current_armor = inv_armor[0]
var current_weapon = inv_weapons[0]


func add_item(item_added):
	var is_added
	for item in inv_items:
		if item[0] == item_added:
			is_added = true
			item[1] += 1
			break
	if not is_added:
		inv_items.append([item_added, 1])

func add_weapon(weapon_added):
	inv_weapons.append(weapon_added)
	
func add_armor(armor_added):
	inv_armor.append(armor_added)

func add_magic(magic_added):
	inv_magic.append(magic_added) 
#TODO change later for inv and then in inventory can be added this
