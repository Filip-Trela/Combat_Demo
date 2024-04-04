extends Node

var transition



#combat variables
var action_list = Actions
var inv_list = InventoryInfo




#male, female
var sex:String
var color_sex
var color_sex_sec

#change secondary colors later
var female_color = Color(0.851, 0.412, 0.886, 1.0) 
var female_color_sec = Color(0.851, 0.412, 0.886, 1.0) 
var male_color = Color(0.0, 0.875, 0.518, 1.0)
var male_color_sec = Color(0.0, 0.875, 0.518, 1.0)



#MORE OF A GLOBAL AUTOLOAD
var is_moving = false
# "moving" , "in menu" , "during action", "dead
var combat_state = "moving"

var follows = 0
var follows_max = 3

var during_follows = false

#moving, menu
var explore_state = "moving"





var phys_skills = [
	action_list.slash,
	action_list.vertical_slash,
	action_list.dodge
]

var mag_skills= [
	action_list.placeH,
	action_list.push,
]


var inv_figures = [
	inv_list.basefigure,

]


var inv_weapons = [
	inv_list.baseweapon,
	inv_list.katana,
	inv_list.canon
]

var inv_items = [
	[inv_list.heal_potion, 1],
	[inv_list.base_item, 1],

]

func add_item(item_added):
	var is_added
	for item in inv_items:
		if item[0] == item_added:
			is_added = true
			item[1] += 1
			break
	if not is_added:
		inv_items.append([item_added, 1])


#PLAYER STATS
var max_hp:int = 100
var current_hp:int = max_hp

var max_mp:int
var current_mp:int

var current_figure
var current_weapon


