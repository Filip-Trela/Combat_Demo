extends Node2D

@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

@onready var anim = get_parent().get_parent().get_node("AnimationTree")

func _ready():
	$Node2D/Sprite2D["modulate"] = PlayerInfo.color_sex_trd

func activate():

	anim.main_to_system()
	
	menu.slave_nr = menu.get_node("SystemButtons").get_child_count() -1
	menu.slave_node = menu.get_node("SystemButtons").get_child(0)
	
	menu.state = "system_butt"

