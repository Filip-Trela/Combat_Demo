extends CharacterBody3D

class_name Enemy_Class_Explore


#first one is self but combat one
@export var combat_self:String



@onready var pathg = get_parent().get_node("Group").get_children()
var path_point = 0
var points_len
var target

var activs
var navi
var player
var anim

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
var walk_speed = 3
var sprint_speed = 7



@onready var main_loop = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()



func _ready():
	anim = $AnimationTree
	activs = get_parent().get_parent().get_parent()
	navi = $NavigationAgent3D
	player = activs.get_parent().get_parent().get_node("Player")

	
	navi.path_desired_distance = 0.5
	navi.target_desired_distance = 0.5
	
	
	points_len = len(pathg) -1
	target = pathg[path_point].global_position
	navi.set_target_position(target)




func _process(delta):
	state_machine()


func _physics_process(delta):
	velocity = mov_vec
	move_and_slide()


func state_machine():
	match state:
		"in path":
			anim.set("parameters/Movement/blend_position", xz_vec.length() / sprint_speed)
			if navi.is_navigation_finished():
				path_point +=1
				if path_point > points_len:
					path_point = 0
				target = pathg[path_point].global_position 
				navi.set_target_position(target)
				
			var next_path_position: Vector3 = navi.get_next_path_position()
			
			direction = global_position.direction_to(next_path_position)
			mov_vec = mov_vec.move_toward(direction * walk_speed, acceleration)
			
			
			#rotating
			xz_vec = Vector2(mov_vec.x, mov_vec.z)
			var model_rot = xz_vec.normalized()
	
			if xz_vec != Vector2(0,0):
				model_rot = model_rot.angle_to(Vector2(0,-1)) 
				$Model.rotation.y = model_rot
			
			
		
		"alerted":
			mov_vec = mov_vec.move_toward(Vector3(0,0,0), deceleration *3)
			
			
		
		"chase":
			anim.set("parameters/Movement/blend_position", xz_vec.length() / sprint_speed)
		 	#updated once per 3 frames or something
			navi.set_target_position(player.global_position)
			
			#later throw this away
			if navi.is_navigation_finished():
				return

			var next_path_position: Vector3 = navi.get_next_path_position()
			
			#velocity =current_agent_position.direction_to(next_path_position) * 7
			direction = global_position.direction_to(next_path_position)
			mov_vec = mov_vec.move_toward(direction * sprint_speed, acceleration)
			
			
			if global_position.distance_to(player.global_position) > reach:
				navi.set_target_position(target)
				state = "search"
		
			#rotating
			xz_vec = Vector2(mov_vec.x, mov_vec.z)
			var model_rot = xz_vec.normalized()
	
			if xz_vec != Vector2(0,0):
				model_rot = model_rot.angle_to(Vector2(0,-1)) 
				$Model.rotation.y = model_rot
		
		
		
		
		
		
		"back to path":
			anim.set("parameters/Movement/blend_position", xz_vec.length() / sprint_speed)
			if navi.is_navigation_finished():
				state = "in path"

			var next_path_position: Vector3 = navi.get_next_path_position()

			direction = global_position.direction_to(next_path_position)
			mov_vec = mov_vec.move_toward(direction * walk_speed, acceleration)
			
			#rotating
			xz_vec = Vector2(mov_vec.x, mov_vec.z)
			var model_rot = xz_vec.normalized()
	
			if xz_vec != Vector2(0,0):
				model_rot = model_rot.angle_to(Vector2(0,-1)) 
				$Model.rotation.y = model_rot
			
		"search":
			mov_vec = mov_vec.move_toward(Vector3(0,0,0), deceleration *3)
			anim["parameters/Transition/transition_request"] = "Search"
			
		"attacked":
			mov_vec = mov_vec.move_toward(Vector3(0,0,0), deceleration)
			
			#rotating
			xz_vec = Vector2(mov_vec.x, mov_vec.z)
			var model_rot = xz_vec.normalized()
	
			if xz_vec != Vector2(0,0):
				model_rot = model_rot.angle_to(Vector2(0,1)) 
				$Model.rotation.y = model_rot
				





func _on_scanner_body_entered(body):
	if state != "chase":
		anim["parameters/Transition/transition_request"] = "Alert"
		state = "alerted"


func attacked():
	anim["parameters/Transition/transition_request"] = "Attacked"
	state = "attacked"


func _on_animation_tree_animation_finished(anim_name):
	print(anim_name)
	match anim_name:
		"Attacked_Explore":
			var wagon = get_parent().get_parent().get_parent()
			wagon.change_to_combat()
			main_loop.change_to_combat()
			self.set_script(load("res://Scenes/MainLoop/Enemy/Base/enemy_class_combat.gd"))
			self._ready()
			
		"Search":
			anim["parameters/Transition/transition_request"] = "Move"
			state = "back to path"
		
		"Alert":
			anim["parameters/Transition/transition_request"] = "Move"
			state = "chase"
