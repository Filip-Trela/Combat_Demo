extends Node





#PLACEHOLDERS
#physical
var slash = {
	"name": "Slash",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,1),
	"damage": 10,
	"marker_position": Vector3(0,0,0),
	"effect_position": Vector3(0,0,2.5),
	"effect_animation": preload("res://Scenes/Combat/effects/SlashP/slash.tscn"),
	"description": "A placeholder action with rotateable marker and x damage",
}






#magic

var placeH = {
	"name": "PlaceHolder",
	"marker_type": "move",
	"marker_size": Vector3(3,3,3),
	"max_distance":8,
	"damage": 40,
	"effect_animation": preload("res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn"),
	"description": "A placeholder action with 25 damage",
}


var heal = {
	"name": "Heal",
	"marker_type": null,
	"marker_size": null,
	"effect_animation": preload("res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn"),
	"description": "A placeholder action with null marker",
}

