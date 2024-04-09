extends CharacterBody3D


#first one is self but combat one
@export var combat_self:String = "res://Scenes/Combat/Enemies/PlaceholderEnemy/PlaceHolderEnemy.tscn"
@export var friend1:String ="res://Scenes/Combat/Enemies/PlaceholderEnemy/PlaceHolderEnemy.tscn"
@export var friend2:String 
@export var friend3:String 
@export var friend4:String 
@export var friend5:String 
var friends = [friend1, friend2, friend3, friend4, friend5]

var friend_list:Array = []


var path:PathFollow3D
var activs
var navi
var player

var path_pos:Vector3

var states=[
	"in path",
	"chase",
	"idling"
]
var state = "in path"

#when bigger than reach, goes to idling
@export var reach:int = 10 #30 is a good amount

func _ready():
	path = get_parent()
	activs = get_parent().get_parent().get_parent()
	navi = $NavigationAgent3D
	player = activs.get_parent().get_parent().get_parent().get_node("Player")
	
	navi.path_desired_distance = 0.5
	navi.target_desired_distance = 0.5

	
	for friend in friends:
		if friend:
			friend_list.append(friend)
			
	#await get_tree().physics_frame
	

func _process(delta):
	pass
	
func _physics_process(delta):
	state_machine()


func state_machine():
	match state:
		"in path":
			path.progress += 0.1
		
		"chase":
		 	#updated once per 3 frames or something
			navi.set_target_position(player.global_position)
			
			if navi.is_navigation_finished():
				return

			var current_agent_position: Vector3 = global_position
			var next_path_position: Vector3 = navi.get_next_path_position()

			velocity = current_agent_position.direction_to(next_path_position) * 7
			
			move_and_slide()
			
			if global_position.distance_to(player.global_position) > reach:
				navi.set_target_position(path_pos)
				state = "idling"
		
		"idling":
			if navi.is_navigation_finished():
				path_pos = self.global_position
				var entity_rot = self.global_rotation
				
				activs.remove_child(self)
				path.add_child(self)
				
				self.global_position = get_parent().global_position
				self.global_rotation = entity_rot
				
				state = "in path"

			var current_agent_position: Vector3 = global_position
			var next_path_position: Vector3 = navi.get_next_path_position()

			velocity = current_agent_position.direction_to(next_path_position) * 7

			move_and_slide()

func _on_area_3d_body_entered(body):
	if state == "in path":
		path_pos = self.global_position
		var entity_pos = self.global_position
		var entity_rot = self.global_rotation
		
		path.remove_child(self)
		activs.add_child(self)
		
		global_position = entity_pos
		global_rotation = entity_rot
		
		state = "chase"


func _on_area_3d_body_exited(body):
	print("body exited")
