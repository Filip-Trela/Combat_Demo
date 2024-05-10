extends CharacterBody3D

@export var dialog = "res://Scenes/Explore/NPC/Base/npc_dialog_base.txt"


var dialog_screen


func _ready():
	dialog_screen = get_parent().get_parent().get_parent().get_node("2d_explore/DialogScreen")
	
func interact():
	dialog_screen.start(dialog)

