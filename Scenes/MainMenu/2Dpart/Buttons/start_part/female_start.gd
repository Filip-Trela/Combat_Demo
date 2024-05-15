extends Node2D


@onready var pload_world = preload("res://Scenes/MainLoop/main_loop.tscn")
var world


	
func activate():
	PlayerInfo.sex = "female"
	PlayerInfo.color_sex = PlayerInfo.female_color
	PlayerInfo.color_sex_sec = PlayerInfo.female_color_sec
	PlayerInfo.color_sex_trd = PlayerInfo.female_color_trd
	PlayerInfo.transition.play("menu_to_explore")
