extends Node2D


@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

@onready var anim = get_parent().get_parent().get_node("AnimationTree")

func _ready():
	$Node2D/Sprite2D["modulate"] = PlayerInfo.color_sex_trd
	
func activate():


	anim.pawn_to_pawnsub()
	
	menu.sub_inventory = PlayerInfo.inv_weapons
	menu.sub_options = len(PlayerInfo.inv_weapons) -1
	menu.sub_type = "weapons"
	

	menu.sub_inventory_set(0)
	menu.state = "invsub_butt"
