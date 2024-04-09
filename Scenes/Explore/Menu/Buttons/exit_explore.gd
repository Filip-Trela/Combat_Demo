extends Node2D


func _ready():
		$Node2D/Sprite2D["modulate"] = PlayerInfo.color_sex_trd
		
func activate():
	PlayerInfo.transition.play("explore_to_menu")
