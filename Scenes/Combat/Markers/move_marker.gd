extends CharacterBody3D

var input_vec = Vector2(0,0)
var transformed_input = Vector2(0,0)
var mov_vec = Vector2(0,0)
var acceleration = 1
var speed = 10

var player

var mouse_x
var mouse_y
var mouse_joint_x
var mouse_joint_y
var mouse_rotat = 0


var max_dis:int
var player_camera


func _ready():
	player = get_parent().get_parent().get_node("Player_combat")
	
func _process(_delta):
	if self.global_position.distance_to(player.global_position) >= max_dis:
		var player_xz = Vector2(player.global_position.x ,player.global_position.z)
		var mark_xz = Vector2(self.global_position.x ,self.global_position.z)
		
		mark_xz = player_xz - mark_xz
		mark_xz = mark_xz.normalized() * max_dis
		
		self.global_position.x = -mark_xz.x + player_xz.x
		self.global_position.z = -mark_xz.y + player_xz.y



func _physics_process(_delta):
	if input_vec != Vector2(0,0):
		mov_vec = mov_vec.move_toward(transformed_input * speed, acceleration)

	else:
		mov_vec = mov_vec.move_toward(Vector2(0,0) ,acceleration)
	
		
	velocity.x = mov_vec.x
	velocity.z = mov_vec.y
	move_and_slide()
	
	
	
func _input(_event):
	input_vec.x = Input.get_action_raw_strength("d") - Input.get_action_raw_strength("a")
	input_vec.y = Input.get_action_raw_strength("s") - Input.get_action_raw_strength("w")
	input_vec = input_vec.normalized()
	
	transformed_input = input_vec.rotated(- player.mouse_joint_y.rotation.y)



func delete_self(): 
	self.queue_free()
