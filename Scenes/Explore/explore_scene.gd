extends Node3D

@onready var female_mesh =preload("res://Assets/3D/Player/Female/Placeholder/female_placeholder.tscn")
@onready var male_mesh = preload("res://Assets/3D/Player/Male/Placeholder/male_placeholder.tscn")

@onready var trainS = $TrainSystem

var player
var player_base
var player_mesh

func _ready():
	trainS.custom_ready()
	
	
	player = get_node("Player")
	player_base = player.get_node("Model/Base")
	player_mesh = player_base.get_node("Mesh")
	
	player_mesh.queue_free()
	if PlayerInfo.sex == "male":
		player_base.call_deferred("add_child",male_mesh.instantiate())
		#player_base.add_child(male_mesh.instantiate())
	else:
		player_base.call_deferred("add_child",female_mesh.instantiate())
		#player_base.add_child(female_mesh.instantiate())
		

