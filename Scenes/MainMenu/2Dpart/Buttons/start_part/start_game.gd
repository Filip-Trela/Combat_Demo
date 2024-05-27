extends Node2D

#@onready var pload_world = preload("res://Scenes/Explore/explore_scene.tscn")
var world


	
func activate():
	PlayerInfo.sex = "male"
	PlayerInfo.color_sex = PlayerInfo.male_color
	PlayerInfo.color_sex_sec = PlayerInfo.male_color_sec
	PlayerInfo.color_sex_trd = PlayerInfo.male_color_trd
	PlayerInfo.transition.play("menu_to_explore")

