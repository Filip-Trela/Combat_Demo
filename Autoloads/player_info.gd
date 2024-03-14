extends Node


#combat variables
var phys_skills = [
	"dodge",
	"punch",
	"kick",
	"wait"
]

var mag_skills= [
	"fireball",
	"blood shoot",
	"heal",
	"explosion"
]

var is_moving = false

# "moving" , "in menu" , "button selected"
var combat_state = "moving"
var in_c_menu = false


