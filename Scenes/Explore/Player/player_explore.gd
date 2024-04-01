extends CharacterBody3D


var input_vec = Vector2(0,0)
var transformed_input = Vector2(0,0)
var xz_vec = Vector2(0,0) #xz axis movement vector
var mov_vec = Vector3(0,0,0) #finall move vector


var direction = PI
var rot_speed = 0.1
var model_rotation 

var acceleration = 0.7
var deceleration = 1
var run_speed = 7
var sprint_speed = 14
var max_speed


var y_vec = 0
var jump_str = 20
var jump_is:bool = false
var gravity = 1
var max_fall = -80


var mouse_x
var mouse_y
var mouse_joint_x
var mouse_joint_y
var mouse_rotat = 0

var mouse_sens = 0.005


@onready var model = $Model

var enemies_in_range:Array = []
var closest_enemy

#placeholder




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#self.set_collision_mask()
	mouse_joint_y = get_node("CameraY")
	mouse_joint_x = mouse_joint_y.get_node("CameraX")
	var head = get_node("Model/testing/Armature/Skeleton3D/Head")


	
	

func _process(_delta):
	model_rotation = Vector2(mov_vec.x, mov_vec.z).normalized()
	if model_rotation != Vector2(0,0):
		model_rotation = model_rotation.angle_to(Vector2(0,-1))
		model.rotation.y = model_rotation
	
	for enemy in enemies_in_range:
		if closest_enemy:
			if closest_enemy.position.distance_to(self.position) > enemy.position.distance_to(self.position):
				closest_enemy = enemy
		else:
			closest_enemy = enemy

		

		

func _physics_process(_delta):
	#xz moving
	if input_vec != Vector2(0,0):
		xz_vec = xz_vec.move_toward(transformed_input * max_speed, acceleration)
		direction = transformed_input.angle_to(Vector2(0,1))
	else:
		xz_vec = xz_vec.move_toward(Vector2(0,0) ,deceleration)
	
	if is_on_floor():
		y_vec = clamp(y_vec, 0, 1000)
	else:
		y_vec -= gravity
		y_vec = clamp(y_vec, max_fall, 1000)
		
	
	mov_vec = Vector3(xz_vec.x,y_vec,xz_vec.y)
	
	velocity = mov_vec
	
	
	#for timer information
	if xz_vec != Vector2(0,0):
		PlayerInfo.is_moving = true
	else:
		PlayerInfo.is_moving = false
		
	move_and_slide()
	





func _input(_event):
	if PlayerInfo.explore_state == "moving":
		input_vec.x = Input.get_action_raw_strength("d") - Input.get_action_raw_strength("a")
		input_vec.y = Input.get_action_raw_strength("s") - Input.get_action_raw_strength("w")
		input_vec = input_vec.normalized()
		
		transformed_input = input_vec.rotated(-mouse_joint_y.rotation.y)
		
		if is_on_floor() and Input.is_action_just_pressed("space"):
			y_vec += jump_str
			
		#for switching to combat
		#placeholder
		if Input.is_action_just_pressed("q") and closest_enemy: 
			PlayerInfo.transition.start_enemy = closest_enemy
			PlayerInfo.transition.play("explore_to_combat")
			
			
			
		
		if Input.is_action_pressed("shift"):
			max_speed = sprint_speed
		else:
			max_speed = run_speed
			
	else:
		input_vec = Vector2(0,0)
		
		
	
	
func camera_handler():
	mouse_joint_y.rotation.y -= mouse_x * mouse_sens
	mouse_joint_x.rotation.x -= mouse_y * mouse_sens
	mouse_joint_x.rotation.x = clamp(mouse_joint_x.rotation.x, -0.4 , 0.05)

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
			$CameraY/CameraX/Camera_pos.position.z -= 3 * 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$CameraY/CameraX/Camera_pos.position.y += 1 * 0.1
			$CameraY/CameraX/Camera_pos.position.z += 3 * 0.1
			
		$CameraY/CameraX/Camera_pos.position.y = clamp($CameraY/CameraX/Camera_pos.position.y, 2.5, 5)
		$CameraY/CameraX/Camera_pos.position.z = clamp($CameraY/CameraX/Camera_pos.position.z, 7.5, 15)
		


func _on_enemy_detector_body_entered(body):
	if body not in enemies_in_range:
		enemies_in_range.append(body)


func _on_enemy_detector_body_exited(body):
	var enemy_nr  = enemies_in_range.find(body)
	if enemy_nr != -1:
		enemies_in_range.remove_at(enemy_nr)
		if closest_enemy == body:
			closest_enemy = null

