extends Node2D


@onready var pload_world = preload("res://Scenes/Explore/explore_scene.tscn")
var world


	
func activate():
	PlayerInfo.sex = "female"
	PlayerInfo.color_sex = PlayerInfo.female_color
	PlayerInfo.transition.play("menu_to_explore")
