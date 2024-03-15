extends Node





#PLACEHOLDERS
#physical
var placeH = {
	"name": "PlaceHolder",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,5),
	"marker_position":Vector3(0,0,2),
}


var punch = {
	"name": "Punch",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,5),
	"marker_position":Vector3(0,0,2),
}

var arrow_rain = {
	"name": "ArrowRain",
	"marker_type": "move",
	"marker_size": Vector3(3,3,3),
	"max_distance":8,
}

var wait = {
	"name": "Wait",
	"marker_type": null,
	"marker_size": null,
}


#magic

var blood_shoot = {
	"name": "BloodShoot",
	"marker_type": "rotate",
	"marker_size": Vector3(1,1,10),
	"marker_position":Vector3(0,0,4),
}

var heal = {
	"name": "Heal",
	"marker_type": null,
	"marker_size": null,
}

var explosion = {
	"name": "Explosion",
	"marker_type": "move",
	"marker_size": Vector3(7,7,7),
	"max_distance":13,

}
