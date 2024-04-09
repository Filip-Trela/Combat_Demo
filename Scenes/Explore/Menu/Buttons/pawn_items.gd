extends Node2D


@onready var exp_world = get_parent().get_parent().get_parent().get_parent()
@onready var game = exp_world.get_parent()
@onready var menu = get_parent().get_parent()

@onready var anim = get_parent().get_parent().get_node("AnimationTree")

func _ready():
	$Node2D/Sprite2D["modulate"] = PlayerInfo.color_sex_trd

func activate():

	anim.pawn_to_pawnitems()
	menu.sub_inventory = PlayerInfo.inv_items
	menu.sub_options = len(PlayerInfo.inv_items) -1
	menu.sub_type = "items"
	
	menu.item_set(0)
	menu.state = "items_butt"

