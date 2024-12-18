extends CanvasLayer

@onready var enemy_indicator = preload("res://Scenes/Explore/Menu/enemy_indicator/enemy_indicator.tscn")
@onready var interact_indicator = preload("res://Scenes/Explore/Menu/interact_indicator/Interact_indicator.tscn")
var e_indicator
var i_indicator


var player
@onready var enemy_ind = $Enemy_indicator
@onready var interact_ind = $Interact_indicator

@onready var anim = get_node("Menu/AnimationTree")



func _ready():
	player = get_parent().get_node("Player")



func _process(delta):
	#DLA OBIEKTOW DO INTERAKCJI
	if player.closest_interact and interact_ind.get_child_count() != 0:
		i_indicator.position = get_viewport().get_camera_3d().\
		unproject_position(player.closest_interact.global_position)
	#gdy powstaje indykator
	elif player.closest_interact and interact_ind.get_child_count()== 0: 
		i_indicator = interact_indicator.instantiate()
		i_indicator.position = get_viewport().get_camera_3d().\
		unproject_position(player.closest_interact.global_position)
		interact_ind.add_child(i_indicator)
	#usuniecie indykatora
	elif not player.closest_interact and interact_ind.get_child_count() != 0:
		interact_ind.get_child(0).end()
	

func _input(event):
	if Input.is_action_just_pressed("tab"):
		if PlayerInfo.explore_state == "menu":
			anim.hide()
			
			$Menu.slave_nr = 0
			$Menu.slave_node = null
			$Menu.choose_s = 0

			$Menu.state = "main_butt"
			$Menu.choose_m = 0
			$Menu.main_butt_change()

			
			PlayerInfo.explore_state = "moving"
		elif PlayerInfo.explore_state == "moving":
			anim.none_to_main()
			
			$Menu.slave_nr = 0
			$Menu.slave_node = null
			$Menu.choose_s = 0
			
			$Menu.state = "main_butt"
			$Menu.choose_m = 0
			$Menu.main_butt_change()
			$Menu.visible = true
			
			PlayerInfo.explore_state = "menu"
