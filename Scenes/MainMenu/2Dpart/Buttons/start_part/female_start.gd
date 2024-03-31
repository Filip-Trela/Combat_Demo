extends Node2D


@onready var pload_world = preload("res://Scenes/Explore/explore_scene.tscn")
var world


	
func activate():
	PlayerInfo.sex = "female"
	world = pload_world.instantiate()
	
	
	get_parent().get_parent().get_parent().get_parent().add_child(world)
	get_parent().get_parent().get_parent().queue_free()
