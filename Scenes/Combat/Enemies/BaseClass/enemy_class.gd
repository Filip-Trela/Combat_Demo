extends CharacterBody3D

class_name Enemy_Class

@onready var sprites = $FlipH

var max_hp = 100
var current_hp = max_hp

func _ready():
	sprites = sprites.get_children()


func _process(_delta):
	for sprite in sprites:
		sprite.sort_z()
	
	if current_hp <=0:
		queue_free()
