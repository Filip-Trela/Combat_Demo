extends Node2D

@onready var game = get_parent()
@onready var anim = $AnimationPlayer

@onready var combat_scene_load = preload("res://Scenes/Combat/combat_scene.tscn")
var combat_scene
var start_enemy


#for now this preload, later determined by explore world
var load_com_world

func _input(event):
	if Input.is_action_just_pressed("end"):
		get_tree().quit()


func play(string):
	get_tree().paused = true
	anim.play(string)
	
	
func manu_to_explore():
	#placeholder map
	var load_world = load("res://Scenes/MainLoop/main_loop.tscn")
	var world = load_world.instantiate()
	game.get_node("MainMenu").queue_free()
	game.add_child(world)



func explore_to_menu():
	var exp_world = get_parent().get_node("MainLoop")
	var menu = load("res://Scenes/MainMenu/main_menu.tscn")
	menu = menu.instantiate()
	PlayerInfo.explore_state = "moving"
	
	game.add_child(menu)
	exp_world.queue_free()


func _on_animation_player_animation_finished(anim_name):
	get_tree().paused = false
