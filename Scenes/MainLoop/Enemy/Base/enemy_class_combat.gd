extends CharacterBody3D

class_name Enemy_Class

var enemy_list

@onready var indicator_p = preload("res://Scenes/Combat/effects/DamageIndicator/damage_indicator.tscn")
@onready var world = get_parent()
@onready var combat_menu = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("CombatMenu")
@onready var anim = $AnimationTree
@onready var combat_world = get_parent().get_parent().get_parent().get_parent().get_parent()
#export values for enemy: weight, y_tossable, health max, weaknesses, damages dealt

@onready var player = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Player")
@onready var navi:NavigationAgent3D = $NavigationAgent3D






################################################################################
@export_group("Init variables")
#from 5 to 15
@export_range(5, 25, 0.2) var weight = 5.0
@export var y_tossable = true
@export var melee_attacks:PackedStringArray
@export var range_attacks:PackedStringArray
@export_range(1, 3, 1) var mind_lvl =1.0
@export var stagger_tresshold = 100
@export var stagger_recovery = 0.05
@export var poise:int = 20 #NWM FOR NOW HOW MUCH
@export_subgroup("Stats")
@export var weaknesses = {
	"weapon": 0,
	"fire": 0,
	"light": 0,
	}
@export var strengths = {
	"weapon": 0,
	"fire": 0,
	"light": 0,
}




@export_group("During animation")
@export var damage_dealt = 20
@export var vulnerable = false
@export var xz_toss:Vector2
################################################################################




var stagger_pts = 0



var max_hp = 100
var current_hp = max_hp








var y_vec = 0
var gravity = 1
var max_fall = -80

var xz_vec:Vector2= Vector2(0,0)
var friction = .1
var direction = Vector3(0,0,0)
var mov_vec = Vector3(0,0,0)
var max_speed = 5
var acceleration = 0.1


#for slowing when player not moving
var time



var states = [
	"approach",
	"attack melee",
	"attack range",
	"run from player",
	"run left",
	"run right",
	"attacked",
	"staggered"
]
var state = "approach"



var attack_name = "attack"


func _ready():
	time = Settings.current_time
	navi.path_desired_distance = .5
	navi.target_desired_distance = .5



func _process(_delta):
	time = Settings.current_time
	$AnimationTree["parameters/Stop/scale"] = time

	
	state_machine()
	#later it doesnt do that during anim staggered


	if PlayerInfo.is_moving:
		stagger_pts = move_toward(stagger_pts, 0, stagger_recovery)
		if xz_vec != Vector2(0,0):
			var model_rot = xz_vec.angle_to(Vector2(0,-1)) 
			$Model.rotation.y = model_rot
		anim["parameters/Stop/scale"] = Settings.current_time
	else:
		anim["parameters/Stop/scale"] = Settings.current_time
		


func _physics_process(delta):
	if is_on_floor():
		y_vec = clamp(y_vec, 0, 1000)
		#xz_vec = xz_vec.move_toward(Vector2(0,0), friction)
	else:
		y_vec -= gravity
		y_vec = clamp(y_vec, max_fall, 1000)
		
	if xz_toss != Vector2(0,0):
		xz_vec += xz_toss.rotated(rotation.y)
		xz_toss = Vector2(0,0)
		
	velocity.x = xz_vec.x * time
	velocity.y = y_vec * time
	velocity.z = xz_vec.y * time
	move_and_slide()

func state_machine():
	match state:
		"approach":
			approach()
				
		"attack melee":
			attack_melee()
				
		"run from player":
			run_from_player()
		
		"run left":
			run_left()
		
		"run right":
			run_right()
		
		"attacked":
			attacked()
			
		"staggered":
			staggered()

#TODO dont know if gonna work
func dash(vec3, pi_rot):
	navi.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navi.get_next_path_position()
	
	direction = global_position.direction_to(next_path_position)
	direction = direction.rotated(Vector3(0,1,0), PI)
	xz_vec = direction * vec3
	
func approach():
	
	
	navi.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navi.get_next_path_position()
	
	direction = global_position.direction_to(next_path_position)
	xz_vec = xz_vec.move_toward(Vector2(direction.x, direction.z) * max_speed, acceleration)

func run_from_player():
	navi.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navi.get_next_path_position()
	
	direction = global_position.direction_to(next_path_position) 
	direction = direction.rotated(Vector3(0,1,0), PI)
	xz_vec = xz_vec.move_toward(Vector2(direction.x, direction.z) * max_speed, acceleration)

func run_left():
	navi.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navi.get_next_path_position()
	
	direction = global_position.direction_to(next_path_position) 
	direction = direction.rotated(Vector3(0,1,0), PI/2)
	xz_vec = xz_vec.move_toward(Vector2(direction.x, direction.z) * max_speed, acceleration)

func run_right():
	navi.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navi.get_next_path_position()
	
	direction = global_position.direction_to(next_path_position) 
	direction = direction.rotated(Vector3(0,1,0), PI/2 *3)
	xz_vec = xz_vec.move_toward(Vector2(direction.x, direction.z) * max_speed, acceleration)
	
func attack_melee():
	
	#anim.play(attack_name)
	#CHANGE LATER WHAT IS BENITH
	xz_vec = xz_vec.move_toward(Vector2(0,0), friction)

func attack_range():
	#anim.play(attack_name)
	xz_vec = xz_vec.move_toward(Vector2(0,0), friction)

func attacked(): 
	xz_vec = xz_vec.move_toward(Vector2(0,0), friction)
	anim["parameters/Transition/transition_request"] = "Attacked"
	
func staggered():
	stagger_pts = 0
	xz_vec = xz_vec.move_toward(Vector2(0,0), friction)
	anim["parameters/Transition/transition_request"] = "Stagger"



func take_damage(damage_nr, action):
	var damage_taken
	var stags:int
	if vulnerable:
		damage_taken = damage_nr * 1.5
		vulnerable = false
		stags = action.stagger* 1.2
		#stagger wyzszy
	
	else: 
		damage_taken = damage_nr
		stags = action.stagger 
		#normal stagger



	var action_str

	var weaks =weaknesses.values()
	var strens = strengths.values()
	weaks.push_front(weaks.back())
	weaks.pop_back()
	strens.push_front(strens.back())
	strens.pop_back()
	
	if action.by_weapon == true:
		action_str = PlayerInfo.current_weapon.strengths
		stags *= PlayerInfo.current_weapon.stagger
	else:
		action_str = action.strengths
	

		
	for i in range(3):
		if action_str[i] ==1:
		#WEAKNESSES
			if weaks[i] == 1:
				damage_taken *= 1.2
				stags *=  1.4
				#stagger wyzszy
				
			
		#STRENGTHS
			if strens[i] == 1:
				damage_taken *= 0.5
				stags = 0
				stagger_pts = 0
				#reset stagger
	
			
	
	if stags > poise:
		state = "attacked"
	
	stagger_pts += stags
	
	if stagger_pts >= stagger_tresshold:
		state = "staggered"
	
	current_hp -= damage_taken
	
	var indicator = indicator_p.instantiate()
	indicator.position = get_viewport().get_camera_3d().unproject_position(self.global_position)
	indicator.text = str(damage_taken)
	
	combat_menu.add_child(indicator)
	
	if current_hp <=0:
		die()



func item_damage(item):
	var damage_taken
	var stags:int
	var item_stats:Array = item.use_on_enemy
	
	if vulnerable: 
		damage_taken = item_stats[0] * 1.5
		vulnerable = false
		stags = item_stats[2] * 1.2
	else:
		damage_taken = item_stats[0] * 1.5
		stags = item_stats[2]


	if stags > poise:
		state = "attacked"
	
	stagger_pts += stags
	
	if stagger_pts >= stagger_tresshold:
		state = "staggered"
	
	current_hp -= damage_taken
	
	var indicator = indicator_p.instantiate()
	indicator.position = get_viewport().get_camera_3d().unproject_position(self.global_position)
	indicator.text = str(damage_taken)
	
	combat_menu.add_child(indicator)
	
	if current_hp <=0:
		die()






func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	area.get_parent().damage_take(damage_dealt)

func die():
	for enemy in Settings.enemy_list:
		if enemy == self:
			Settings.enemy_list.pop_back()
	queue_free()


func _on_animation_tree_animation_finished(anim_name):
	anim["parameters/Transition/transition_request"] = "Move"
	state = "approach"



func _on_scanner_body_entered(body):
	pass # Replace with function body.
