extends Node3D

var world

var enemy_group
var load_com_world


var explore_world
var start_enemy
var enemy_list
var enemy_size

var start_nodes
var start_amount

var start_group

#player
@onready var player_pl = preload("res://Scenes/Combat/Player/player_combat.tscn")

#later will be figures but for now only meshes
@onready var female_mesh =preload("res://Assets/3D/Player/Female/Placeholder/female_placeholder.tscn")
@onready var male_mesh = preload("res://Assets/3D/Player/Male/Placeholder/male_placeholder.tscn")





# Called when the node enters the scene tree for the first time.
func _ready():
	load_com_world = load(load_com_world)
	load_com_world = load_com_world.instantiate()
	$ShiftPivot/World.add_child(load_com_world)
	
	world = $ShiftPivot/World.get_child(0)
	enemy_group = $ShiftPivot/World.get_child(0).get_node("Enemies")
	
	
	start_nodes = $ShiftPivot/World.get_child(0).get_node("Start_positions")
	
	start_amount = start_nodes.get_child_count()
	start_group = start_nodes.get_child(randi_range(1, start_amount) -1)
	
	#add player
	var player = player_pl.instantiate()
	player.position = start_group.get_node("Player").position
	
	player.get_node("Model/animNode/Base/Mesh").queue_free()
	if PlayerInfo.sex == "male":
		player.get_node("Model/animNode/Base").add_child(male_mesh.instantiate())
	else:
		player.get_node("Model/animNode/Base").add_child(female_mesh.instantiate())
	
	
	
	
	world.add_child(player)
	
	get_node("ShiftPivot/CombatMenu/ButtonHandler").player = player
	
	
	#setting enemies in combat world
	enemy_list = start_enemy.friend_list
	
	var nr =0
	for node in start_group.get_node("Enemies").get_children():
		if nr ==0:
			var enemy = load(start_enemy.combat_self)
			enemy = enemy.instantiate()
			enemy.position = node.position
			world.get_node("Enemies").add_child(enemy)
		else:
			var enemy = load(enemy_list[randi_range(0,enemy_list.size()-1)])
			enemy = enemy.instantiate()
			enemy.position = node.position
			world.get_node("Enemies").add_child(enemy)
		nr +=1
	
	$ShiftPivot/World.get_child(0).get_node("Start_positions").queue_free()

	get_node("ShiftPivot/CombatMenu/ButtonHandler").ready_custom()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	#dac pozniej dwie opcje wlasnie, gdzie gdy player zginie odradza sie w jakims miejscu i pomija czas
	if enemy_group.get_child_count() ==0:
		
		PlayerInfo.transition.play("combat_to_explore_playerwins")
