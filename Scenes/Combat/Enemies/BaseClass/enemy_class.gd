extends CharacterBody3D

class_name Enemy_Class

@onready var indicator_p = preload("res://Scenes/Combat/effects/DamageIndicator/damage_indicator.tscn")
@onready var world = get_parent()
@onready var combat_menu = get_parent().get_parent().get_node("CombatMenu")
@onready var anim:AnimationPlayer = $AnimationPlayer

#export values for enemy: weight, y_tossable, health max, weaknesses, damages dealt



#from 5 to 20, the more the more he weights
#5 easy push, 20 almost no push
@export_range(5, 20) var weight:int = 5
@export var y_tossable = true

var max_hp = 100
var current_hp = max_hp

var damage_dealt = 20

var anim_played:String

var vulnerable = false

var xz_vec:Vector2= Vector2(0,0)
var friction = 1
var y_vec = 0
var gravity = 1
var max_fall = -50



func _ready():
	weight = clamp(weight, 5, 20)
	anim_played = anim.current_animation


func _process(_delta):
	if PlayerInfo.is_moving:
		anim.play(anim_played)
	else:
		anim_played = anim.current_animation
		anim.pause()
	

func _physics_process(delta):
	if PlayerInfo.is_moving:
		
		if is_on_floor():
			y_vec = clamp(y_vec, 0, 1000)
			xz_vec = xz_vec.move_toward(Vector2(0,0), friction)
		else:
			y_vec -= gravity
			y_vec = clamp(y_vec, max_fall, 1000)
		
		
		
		
		velocity.x = xz_vec.x
		velocity.y = y_vec
		velocity.z = xz_vec.y
		move_and_slide()




func take_damage(damage_nr):
	var damage_taken
	if vulnerable:
		damage_taken = damage_nr * 2
		anim_played = "idle"
		anim.play(anim_played)
		vulnerable = false
		
	else: 
		damage_taken = damage_nr
		
	current_hp -= damage_taken
	
	var indicator = indicator_p.instantiate()
	indicator.position = get_viewport().get_camera_3d().unproject_position(self.global_position)
	indicator.text = str(damage_taken)
	
	combat_menu.add_child(indicator)
	
	if current_hp <=0:
		queue_free()



func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):	
	PlayerInfo.current_hp -= damage_dealt

func start_vulnerable():
	vulnerable = true

func end_vulnerable():
	vulnerable = false
