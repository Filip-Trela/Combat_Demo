extends Node


#base dict for all actions

var base = {
	"name": "base",
	"by_player": false,
	"marker_type": null,
	"marker_size": Vector3(1,1,1),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,0),
	"effect_animation": "res://Scenes/Combat/effects/SlashP/slash.tscn",
	"follow_allowed": false,
	"xz_toss": Vector2(0,0), #odrzut
	"y_toss": 0,
	"player_xz_toss": Vector2(0,0), #odrzut
	"hold_in_player":false,
	"by_weapon": false,
	"self_cost": [0,0,0], #hp, mp, sp
	"stagger": [5],
	"damage": 0,
	"player_animation": "Slash",
	"description": "base dictionary for actions",
}

var dodge_cost = 10

#PLACEHOLDERS
#physical
var slash = {
	"name": "Slash",
	"by_player": true,
	"marker_type": "null",
	"marker_size": Vector3(1,1,1),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,0),
	"effect_animation": "res://Scenes/Combat/effects/SlashP/slash.tscn",
	"follow_allowed": true,
	"xz_toss": Vector2(0,0),
	"y_toss": 0,
	"player_xz_toss": Vector2(0,20), #odrzut
	"hold_in_player":true,
	"by_weapon": true,
	"self_cost": [0,0, 10],
	"stagger": 2,
	"damage": [1],
	"player_animation": "Slash",
	"description": "A placeholder action with rotateable marker and x damage",
}
var vertical_slash = {
	"name": "VerticalSlash",
	"by_player": true,
	"marker_type": "null",
	"marker_size": Vector3(0,0,0),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(0,0,0),
	"effect_position": Vector3(0,0,0),
	"effect_animation": "res://Scenes/Combat/effects/SlashP/vertical_slash.tscn",
	"follow_allowed": true,
	"xz_toss": Vector2(0,0), #odrzut
	"y_toss": 5,
	"player_xz_toss": Vector2(0,5),
	"hold_in_player":true,
	"by_weapon": true,
	"self_cost": [0,0, 15],
	"stagger": 5,
	"damage": [0],
	"player_animation": "Vertical",
	"description": "vertical slash placeholder",
}


var multislash = {
	"name": "MultiSlash",
	"by_player": false,
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,1),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(1,1,1),
	"effect_position": Vector3(0,0,4),
	"effect_animation": "res://Scenes/Combat/effects/Multislash/multislash.tscn",
	"follow_allowed": true,
	"xz_toss": Vector2(0,0), #odrzut
	"y_toss": 0,
	"player_xz_toss": Vector2(0,10), #odrzut
	"hold_in_player":false,
	"by_weapon": true,
	"self_cost": [0,0, 40],
	"stagger": 5,
	"damage": [2,2,10],
	"player_animation": "Slash",
	"description": "Multislash action",
}





################################################################################

#magic

var placeH = {
	"name": "PlaceHolder",
	"by_player": false,
	"id":000,
	"marker_type": "move",
	"marker_size": Vector3(5,5,5), 
	"max_distance":20,
	"effect_size": Vector3(2,2,2),
	"xz_toss": Vector2(0,15),
	"y_toss": 15,
	"player_xz_toss": Vector2(0,0),
	"hold_in_player":false,
	"by_weapon": false,
	"self_cost": [0,25,0],
	"strengths": [0,1,0],
	"stagger": 50,
	"damage": [20],
	"effect_animation": "res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn",
	"follow_allowed": false,
	"player_animation": "Slash",
	"description": "A placeholder action with 25 damage",
}


var push = {
	"name": "Push",
	"id":001,
	"by_player": false,
	"marker_type": "null",
	"marker_size": Vector3(0,0,0),
	"marker_position": Vector3(0,0,0),
	"effect_size": Vector3(4,4,4),
	"effect_position": Vector3(0,0,0),
	"effect_animation": "res://Scenes/Combat/effects/PlaceHolder/BoomP.tscn",
	"follow_allowed": false,
	"xz_toss": Vector2(0,20), #odrzut
	"y_toss": 20,
	"player_xz_toss": Vector2(0,0),
	"hold_in_player":false,
	"by_weapon": false,
	"self_cost": [0,30, 0],
	"stagger": 5,
	"strengths": [0,1,0],
	"damage": [0],
	"player_animation": "Slash",
	"description": "A placeholder push action",
}

var all_magic = [placeH, push]

func find_magic(id):
	for magic in all_magic:
		if magic.id == id:
			return magic
