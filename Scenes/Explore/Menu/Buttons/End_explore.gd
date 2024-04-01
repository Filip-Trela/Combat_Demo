extends Node2D

@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()

func activate():
	PlayerInfo.transition.play("explore_to_menu")
