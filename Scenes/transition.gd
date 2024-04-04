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
	combat_scene = combat_scene_load.instantiate()
	combat_scene.start_enemy = start_enemy
	combat_scene.load_com_world = load_com_world
	
	var exp_world = get_parent().get_node("ExploreScene")
	var packed_scene = PackedScene.new()
	packed_scene.pack(exp_world)
	ResourceSaver.save(packed_scene , "res://Runtime/ExploreWorldSaved.tscn")
	
	game.add_child(combat_scene)
	exp_world.queue_free()

	
func combat_to_explore_playerdies():
		var exp_world = load("res://Runtime/ExploreWorldSaved.tscn")
		exp_world = exp_world.instantiate()
	
		PlayerInfo.current_hp = PlayerInfo.max_hp
		PlayerInfo.combat_state = "moving"
		
		get_parent().add_child(exp_world)
		get_parent().get_node("CombatScene").queue_free()


func combat_to_explore_playerwins():
		var exp_world = load("res://Runtime/ExploreWorldSaved.tscn")
		exp_world = exp_world.instantiate()
	

		PlayerInfo.combat_state = "moving"
		
		get_parent().add_child(exp_world)
		get_parent().get_node("CombatScene").queue_free()

func _on_animation_player_animation_finished(anim_name):
	get_tree().paused = false
