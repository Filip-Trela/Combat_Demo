extends Node


#combat variables
var action_list = Actions



var phys_skills = [
	action_list.placeH,
	action_list.punch,
	action_list.arrow_rain,
	action_list.wait
]

var mag_skills= [
	action_list.blood_shoot,
	action_list.heal,
	action_list.explosion
]

var is_moving = false

# "moving" , "in menu" , "button selected"
var combat_state = "moving"



