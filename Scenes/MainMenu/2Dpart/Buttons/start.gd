extends Node2D

@onready var pload_world = preload("res://Scenes/Combat/combat_scene.tscn")
var world


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate(): 
	world = pload_world.instantiate()
	
	get_parent().get_parent().get_parent().get_parent().add_child(world)
	get_parent().get_parent().get_parent().queue_free()
