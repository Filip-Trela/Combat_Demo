extends Node2D


@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

@onready var anim = get_parent().get_parent().get_node("AnimationTree")

func activate():
	anim.main_to_magic()
	
	menu.slave_nr = menu.get_node("MagicButtons").get_child_count() -1
	menu.slave_node = menu.get_node("MagicButtons").get_child(0)
	menu.magic_slot_set(0)
	menu.state = "magic_butt"