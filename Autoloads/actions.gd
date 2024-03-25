extends Node


#base dict for all actions

var base = {
	"name": "base",
	"marker_type": null,
	"marker_size": Vector3(1,1,1),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,0),
	"effect_animation": preload("res://Scenes/Combat/effects/SlashP/slash.tscn"),
	"follow_allowed": false,
	"xz_toss": Vector2(0,0), #odrzut
	"y_toss": 0,
	"damage": 0,
	"description": "base dictionary for actions",
}


#PLACEHOLDERS
#physical
var slash = {
	"name": "Slash",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,1),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,2.5),
	"effect_animation": preload("res://Scenes/Combat/effects/SlashP/slash.tscn"),
	"follow_allowed": true,
	"xz_toss": Vector2(0,10),
	"y_toss": 0,
	"damage": 1,
	"description": "A placeholder action with rotateable marker and x damage",
}






#magic

var placeH = {
	"name": "PlaceHolder",
	"marker_type": "move",
	"marker_size": Vector3(5,5,5), 
	"max_distance":20,
	"effect_size": Vector3(2,2,2),
	"xz_toss": Vector2(0,15),
	"y_toss": 15,
	"damage": 1,
	"effect_animation": preload("res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn"),
	"follow_allowed": false,
	"description": "A placeholder action with 25 damage",
}


var push = {
	"name": "Push",
	"marker_type": null,
	"marker_size": null,
	"marker_position": null,
	"effect_size": Vector3(5,5,5),
	"effect_position": null,
	"effect_animation": preload("res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn"),
	"follow_allowed": false,
	"xz_toss": Vector2(0,25), #odrzut
	"y_toss": 20,
	"damage": 0,
	"description": "A placeholder push action",
}

