extends Node

var transition



#combat variables
var action_list = Actions



var phys_skills = [
	action_list.slash,
	action_list.vertical_slash,
	action_list.dodge
]

var mag_skills= [
	action_list.placeH,
	action_list.push,
]

#PLAYER STATS
var max_hp:int = 100
var current_hp:int = max_hp

var max_mp:int
var current_mp:int

#male, female
var sex:String
var color_sex

var female_color = Color(0.851, 0.412, 0.886, 1.0) 
var male_color = Color(0.0, 0.875, 0.518, 1.0)



#MORE OF A GLOBAL AUTOLOAD
var is_moving = false
# "moving" , "in menu" , "during action", "dead
var combat_state = "moving"

var follows = 0
var follows_max = 3

var during_follows = false

#moving, menu
var explore_state = "moving"


