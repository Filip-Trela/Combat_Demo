extends Node3D

var wagons = [
"res://Scenes/Explore/Wagons/Placeholder/wagon_boss.tscn",
"res://Scenes/Explore/Wagons/Placeholder/wagon_empty.tscn",
"res://Scenes/Explore/Wagons/Placeholder/wagon_enemy.tscn",
"res://Scenes/Explore/Wagons/Placeholder/wagon_items.tscn",
"res://Scenes/Explore/Wagons/Placeholder/wagon_npc.tscn"



]

@onready var world = get_parent()
var player

var center_wagon
var start_wagon
var end_wagon


var all_events = [
	"normal",
	"dark"
]

var index_wag = 0

var current_event = "normal"

func custom_ready():
	#center
	center_wagon = load(choose_wagon(index_wag)).instantiate()
	add_child(center_wagon)
	
	center_wagon.monitor()
	
	PlayerInfo.transition.load_com_world = center_wagon.combat_world
	
	#start
	start_wagon = load(choose_wagon(index_wag +1)).instantiate()
	add_child(start_wagon)
	start_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("Start").position - start_wagon.get_node("End").position
	
	start_wagon.not_monitor()
	

	#end
	end_wagon = load(choose_wagon(index_wag -1)).instantiate()
	add_child(end_wagon)
	end_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("End").position - end_wagon.get_node("Start").position
		
	end_wagon.not_monitor()
		
	player = get_parent().get_node("Player")
	$Enviroment.player = player
	
	index_wag +=1


func create_start():
	index_wag +=1

	
	remove_child(end_wagon)
	end_wagon = center_wagon
	center_wagon = start_wagon
	
	start_wagon = load(choose_wagon(index_wag)).instantiate()
	add_child(start_wagon)
	start_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("Start").position - start_wagon.get_node("End").position
	
	end_wagon.not_monitor()
	center_wagon.monitor()
	start_wagon.not_monitor()
	
	PlayerInfo.transition.load_com_world = center_wagon.combat_world

func create_end():
	index_wag -=1
	
	remove_child(start_wagon)
	start_wagon = center_wagon
	center_wagon = end_wagon
	
	end_wagon = load(choose_wagon(index_wag)).instantiate()
	add_child(end_wagon)
	end_wagon.global_position = center_wagon.global_position\
	+ center_wagon.get_node("End").position - end_wagon.get_node("Start").position
	
	end_wagon.not_monitor()
	center_wagon.monitor()
	start_wagon.not_monitor()
	
	PlayerInfo.transition.load_com_world = center_wagon.combat_world



func choose_wagon(index):
	match index:
		0:
			return "res://Scenes/Explore/Wagons/DEMO/start_wagon.tscn"
		1:
			return "res://Scenes/Explore/Wagons/DEMO/enemy_wagon_01.tscn"
		3:
			return "res://Scenes/Explore/Wagons/DEMO/hub.tscn"
		_:
			return wagons[randf_range(0, len(wagons))]
