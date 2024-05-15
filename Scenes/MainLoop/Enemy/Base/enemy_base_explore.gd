extends CharacterBody3D


#first one is self but combat one
@export var combat_self:String ="res://Scenes/Combat/Enemies/1ExplosiveEnemies/robo_boom.tscn"
@export var friend1:String ="res://Scenes/Combat/Enemies/1ExplosiveEnemies/robo_boom.tscn"
@export var friend2:String 
@export var friend3:String 
@export var friend4:String 
@export var friend5:String 
var friends = [friend1, friend2, friend3, friend4, friend5]

var friend_list:Array = []


@onready var pathg = get_parent().get_node("Group").get_children()
var path_point = 0
var points_len
var target

var activs
var navi
var player
@onready var anim = $AnimationPlayer

var path_pos:Vector3

var states=[
	"in path",
	"alerted",
	"chase",
	"search",
	"back to path"
]
var state = "in path"

#when bigger than reach, goes to idling
@export var reach:int = 10 #30 is a good amount





var mov_vec = Vector3(0,0,0)
var xz_vec = Vector2(0,0)
var direction = Vector3(0,0,0)
var acceleration = 0.1
var deceleration = 0.4
var max_speed = 7





func _ready():
	activs = get_parent().get_parent().get_parent()
	navi = $NavigationAgent3D
	player = activs.get_parent().get_parent().get_node("Player")

	
	navi.path_desired_distance = 0.5
	navi.target_desired_distance = 0.5
	
	
	points_len = len(pathg) -1
	target = pathg[path_point].global_position
	navi.set_target_position(target)

	
	for friend in friends:
		if friend:
			friend_list.append(friend)
			
	

func _process(delta):
	
	xz_vec = Vector2(mov_vec.x, mov_vec.z)
	var model_rot = xz_vec.normalized()
	
	if xz_vec != Vector2(0,0):
		model_rot = model_rot.angle_to(Vector2(0,-1)) 
		$Model.rotation.y = model_rot



func _physics_process(delta):
	state_machine()


func state_machine():
	match state:
		"in path":
			if navi.is_navigation_finished():
				path_point +=1
				if path_point > points_len:
					path_point = 0
				target = pathg[path_point].global_position 
				navi.set_target_position(target)
				
			var next_path_position: Vector3 = navi.get_next_path_position()
			
			direction = global_position.direction_to(next_path_position)
			mov_vec = mov_vec.move_toward(direction * max_speed, acceleration)
			
			velocity = mov_vec
			move_and_slide()
			
		
		"alerted":
			anim.play("alert")
			
		
		"chase":
		 	#updated once per 3 frames or something
			navi.set_target_position(player.global_position)
			
			#later throw this away
			if navi.is_navigation_finished():
				return

			var next_path_position: Vector3 = navi.get_next_path_position()
			
			#velocity =current_agent_position.direction_to(next_path_position) * 7
			direction = global_position.direction_to(next_path_position)
			mov_vec = mov_vec.move_toward(direction * max_speed, acceleration)
			
			velocity = mov_vec
			move_and_slide()
			
			if global_position.distance_to(player.global_position) > reach:
				navi.set_target_position(target)
				state = "search"
		
		"back to path":
			if navi.is_navigation_finished():
				state = "in path"

			var next_path_position: Vector3 = navi.get_next_path_position()

			direction = global_position.direction_to(next_path_position)
			mov_vec = mov_vec.move_toward(direction * max_speed, acceleration)
			
			velocity = mov_vec
			move_and_slide()
			
		"search":
			anim.play("search")

func _on_scanner_body_entered(body):
	if state != "chase":
		state = "chase"


func _on_scanner_body_exited(body):
	pass#print("body exited")


func alert_anim_stop(): 
	state = "chase"

func search_anim_stop():
	mov_vec = Vector3(0,0,0)
	state = "back to path"


func change_combat():
	self.set_script(load('res://Scenes/Combat/Enemies/BaseClasses/enemy_class.gd'))
	self._ready()
