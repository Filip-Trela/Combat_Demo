extends CharacterBody3D

class_name Enemy_Class

@onready var sprites = $FlipH


func _ready():
	sprites = sprites.get_children()


func _process(delta):
	for sprite in sprites:
		sprite.sort_z()
