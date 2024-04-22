extends Node3D

@onready var wagonpl = "res://Scenes/Explore/Wagons/Placeholder/wagon_ph.tscn"
@onready var world = get_parent()
var player

var center_wagon
var start_wagon
var end_wagon

func custom_ready():
	#center
	center_wagon = load(wagonpl).instantiate()
	add_child(center_wagon)
	
	center_wagon.monitor()
	
	PlayerInfo.transition.load_com_world = center_wagon.combat_world
	
	#start
	start_wagon = load(wagonpl).instantiate()
	add_child(start_wagon)
	start_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("Start").position - start_wagon.get_node("End").position
	
	start_wagon.not_monitor()
	

	#end
	end_wagon = load(wagonpl).instantiate()
	add_child(end_wagon)
	end_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("End").position - end_wagon.get_node("Start").position
		
	end_wagon.not_monitor()
		
	player = get_parent().get_node("Player")
	$Enviroment.player = player


func create_start():
	remove_child(end_wagon)
	end_wagon = center_wagon
	center_wagon = start_wagon
	
	start_wagon = load(wagonpl).instantiate()
	add_child(start_wagon)
	start_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("Start").position - start_wagon.get_node("End").position
	
	end_wagon.not_monitor()
	center_wagon.monitor()
	start_wagon.not_monitor()
	
	PlayerInfo.transition.load_com_world = center_wagon.combat_world

func create_end():
	remove_child(start_wagon)
	start_wagon = center_wagon
	center_wagon = end_wagon
	
	end_wagon = load(wagonpl).instantiate()
	add_child(end_wagon)
	end_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("End").position - end_wagon.get_node("Start").position
	
	end_wagon.not_monitor()
	center_wagon.monitor()
	start_wagon.not_monitor()
	
	PlayerInfo.transition.load_com_world = center_wagon.combat_world
