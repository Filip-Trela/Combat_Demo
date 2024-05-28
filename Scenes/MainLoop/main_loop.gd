extends Node3D

@onready var female_mesh =preload("res://Assets/3D/Player/Female/Placeholder/female_placeholder.tscn")
@onready var male_mesh = preload("res://Assets/3D/Player/Male/animated_player.tscn")

@onready var trainS = $ShiftPivot/TrainSystem

var player
var player_base
var player_mesh

var world_enviroment

func _ready():
	world_enviroment = get_parent().get_node("WorldEnvironment")

	trainS.custom_ready()
	
	
	player = get_node("ShiftPivot/Player")

func change_to_combat():
	var shift = get_node("ShiftPivot")
	var player = shift.get_node("Player")
	
	shift.get_node("2d_explore").set_process_mode(Node.PROCESS_MODE_DISABLED)
	shift.get_node("2d_explore").visible = false
	shift.get_node("CombatMenu").set_process_mode(Node.PROCESS_MODE_INHERIT)
	shift.get_node("CombatMenu/ButtonHandler")._ready()
	shift.get_node("CombatMenu").visible = true
	

	player.set_script(load("res://Scenes/MainLoop/Player/Player_Combat.gd"))
	player._ready()

func change_to_explore():
	var shift = get_node("ShiftPivot")
	var player = shift.get_node("Player")
	
	shift.get_node("2d_explore").set_process_mode(Node.PROCESS_MODE_INHERIT)
	shift.get_node("2d_explore").visible = true
	shift.get_node("CombatMenu").set_process_mode(Node.PROCESS_MODE_DISABLED)
	shift.get_node("CombatMenu").visible = false
	

	player.set_script(load("res://Scenes/MainLoop/Player/Player_explore.gd"))
	player._ready()
	
