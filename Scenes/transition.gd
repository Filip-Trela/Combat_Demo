extends Node2D

@onready var game = get_parent()
@onready var anim = $AnimationPlayer

var start_enemy


#for now this preload, later determined by explore world
var pl_com_world = preload("res://Scenes/Combat/combat_scene.tscn")
var com_world


func _process(delta):
	if anim.is_playing():
		get_tree().paused = true
	else:
		get_tree().paused = false

func play(string):
	anim.play(string)
	
	
func manu_to_explore():
	#placeholder map
	var load_world = load("res://Scenes/Explore/explore_scene.tscn")
	var world = load_world.instantiate()
	game.get_node("MainMenu").queue_free()
	game.add_child(world)

func explore_to_menu():
	var exp_world = get_parent().get_node("ExploreScene")
	var menu = load("res://Scenes/MainMenu/main_menu.tscn")
	menu = menu.instantiate()
	PlayerInfo.explore_state = "moving"
	
	game.add_child(menu)
	exp_world.queue_free()






func explore_to_combat():
	var exp_world = get_parent().get_node("ExploreScene")
	com_world = pl_com_world.instantiate()
	com_world.start_enemy = start_enemy
	
	var packed_scene = PackedScene.new()
	packed_scene.pack(exp_world)
	ResourceSaver.save(packed_scene , "res://Runtime/ExploreWorldSaved.tscn")
	
	game.add_child(com_world)
	exp_world.queue_free()

	

