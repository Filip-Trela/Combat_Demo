extends Node


#combat variables
var action_list = Actions



var phys_skills = [
	action_list.slash,
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



#MORE OF A GLOBAL AUTOLOAD
var is_moving = false
# "moving" , "in menu" , "during action"
var combat_state = "moving"

var follows = 0
var follows_max = 3

var during_follows = false


