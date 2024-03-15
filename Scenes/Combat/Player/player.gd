extends CharacterBody3D

var input_vec = Vector2(0,0)
var transformed_input = Vector2(0,0)
var xz_vec = Vector2(0,0) #xz axis movement vector
var mov_vec = Vector3(0,0,0) #finall move vector
var y_vec = 0

var direction = 0

var acceleration = 0.7
var deceleration = 1
var max_speed = 7



var mouse_x
var mouse_y
var mouse_joint_x
var mouse_joint_y
var mouse_rotat = 0

var mouse_sens = 0.005




@onready var model = $Model






func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
	mouse_joint_y = get_node("CameraY")
	mouse_joint_x = mouse_joint_y.get_node("CameraX")

func _process(delta):
	model.rotation.y = mouse_joint_y.rotation.y
	
	

		

func _physics_process(delta):
	#xz moving
	if input_vec != Vector2(0,0):
		xz_vec = xz_vec.move_toward(transformed_input * max_speed, acceleration)
		direction = transformed_input.angle_to(Vector2(0,1))
	else:
		xz_vec = xz_vec.move_toward(Vector2(0,0) ,deceleration)
		
	
	mov_vec = Vector3(xz_vec.x,y_vec,xz_vec.y)
	
	velocity = mov_vec
	
	
	#for timer information
	if velocity == Vector3(0,0,0):
		PlayerInfo.is_moving = false
	else:
		PlayerInfo.is_moving = true
		
		
		
	move_and_slide()





func _input(event):
	if PlayerInfo.combat_state == "moving":
		input_vec.x = Input.get_action_raw_strength("a") - Input.get_action_raw_strength("d")
		input_vec.y = Input.get_action_raw_strength("w") - Input.get_action_raw_strength("s")
		input_vec = input_vec.normalized()
	
		transformed_input = input_vec.rotated(-mouse_joint_y.rotation.y)







	#placeholder
	if Input.is_action_just_pressed("end"): get_tree().quit()
	
	
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
		
		
		
		#scroll
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$CameraY/CameraX/Camera_pos.position.y -= 1 * 0.1
			$CameraY/CameraX/Camera_pos.position.z += 3 * 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$CameraY/CameraX/Camera_pos.position.y += 1 * 0.1
			$CameraY/CameraX/Camera_pos.position.z -= 3 * 0.1
			
		$CameraY/CameraX/Camera_pos.position.y = clamp($CameraY/CameraX/Camera_pos.position.y,2.5,5)
		$CameraY/CameraX/Camera_pos.position.z = clamp($CameraY/CameraX/Camera_pos.position.z,-15,-7.5)
		



func tween_camera():
	var tween_c = get_tree().create_tween()
	tween_c.tween_property($CameraY/CameraX/Camera_pos/Camera3D, "global_position", $CameraY/CameraX/Camera_pos.global_position, 0.2)
