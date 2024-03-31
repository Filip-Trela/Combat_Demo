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
	"player_xz_toss": Vector2(0,0), #odrzut
	"hold_in_player":false,
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
	"effect_position": Vector3(0,0,0),
	"effect_animation": preload("res://Scenes/Combat/effects/SlashP/slash.tscn"),
	"follow_allowed": true,
	"xz_toss": Vector2(0,8),
	"y_toss": 0,
	"player_xz_toss": Vector2(0,20), #odrzut
	"hold_in_player":true,
	"damage": 1,
	"description": "A placeholder action with rotateable marker and x damage",
}
var vertical_slash = {
	"name": "VerticalSlash",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,1),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,0),
	"effect_animation": preload("res://Scenes/Combat/effects/SlashP/vertical_slash.tscn"),
	"follow_allowed": true,
	"xz_toss": Vector2(0,0), #odrzut
	"y_toss": 5,
	"player_xz_toss": Vector2(0,0),
	"hold_in_player":false,
	"damage": 0,
	"description": "vertical slash placeholder",
}

var dodge = {
	"name": "Dodge",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,5),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,0),
	"effect_animation": preload("res://Scenes/Combat/effects/dodge/dodge_effect.tscn"),
	"follow_allowed": false,
	"xz_toss": Vector2(0,0), #odrzut
	"y_toss": 0,
	"player_xz_toss": Vector2(0,40), #odrzut
	"hold_in_player":false,
	"damage": 0,
	"description": "dodge action",
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
	"player_xz_toss": Vector2(0,0),
	"hold_in_player":false,
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
	"effect_size": Vector3(4,4,4),
	"effect_position": null,
	"effect_animation": preload("res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn"),
	"follow_allowed": false,
	"xz_toss": Vector2(0,20), #odrzut
	"y_toss": 20,
	"player_xz_toss": Vector2(0,0),
	"hold_in_player":false,
	"damage": 0,
	"description": "A placeholder push action",
}

