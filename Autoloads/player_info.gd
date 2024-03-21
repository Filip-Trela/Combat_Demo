extends Node


#combat variables
var action_list = Actions



var phys_skills = [
	action_list.placeH
]

var mag_skills= [
	action_list.blood_shoot,
	action_list.heal,
	action_list.explosion
]

#PLAYER STATS
var max_hp:int
var current_hp:int

var max_mp:int
var current_mp:int



#MORE OF A GLOBAL AUTOLOAD
var is_moving = false

# "moving" , "in menu" , "button selected"
var combat_state = "moving"



