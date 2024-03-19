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

var mouse_sens = 0.005

var max_dis:int



func _ready():
	player = get_parent().get_parent().get_node("Player")


	
	mouse_joint_y = get_node("CameraY")
	mouse_joint_x = mouse_joint_y.get_node("CameraX")
	
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
	input_vec.x = Input.get_action_raw_strength("a") - Input.get_action_raw_strength("d")
	input_vec.y = Input.get_action_raw_strength("w") - Input.get_action_raw_strength("s")
	input_vec = input_vec.normalized()
	
	transformed_input = input_vec.rotated(- player.mouse_joint_y.rotation.y)



func camera_handler():
	mouse_joint_y.rotation.y -= mouse_x * mouse_sens
	mouse_joint_y.rotation.y = clamp(mouse_joint_y.rotation.y, -0.45 , 0.45)
	mouse_joint_x.rotation.x += mouse_y * mouse_sens
	mouse_joint_x.rotation.x = clamp(mouse_joint_x.rotation.x, -0.05 , 0.4)

	mouse_x = 0
	mouse_y = 0
	
	mouse_rotat = get_node("CameraY").rotation.y

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_x = event.relative.x
		mouse_y = event.relative.y

		camera_handler()

func delete_self(): 
	var player_cam = player.get_node("CameraY/CameraX/Camera_pos/PlayerCamera")
	var marker_cam = get_node("CameraY/CameraX/Camera3D")
	
	player_cam.global_position = marker_cam.global_position
	player.tween_camera()
