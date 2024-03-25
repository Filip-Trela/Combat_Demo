extends Node3D

class_name EffectAnimation

@onready var anims = $AnimationPlayer

@export var damage_base = 25

var action

var hitted = false
var no_follows = false
var last_follow = false #chyba jest potrzebne
var follow_allowed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	damage_base = action.damage
	follow_allowed = action.follow_allowed
	self.scale = action.effect_size
	anim_plays()
	anims.play("start")
	
	
func _process(delta):
	pass


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	hitted = true
	
	var distance = self.position.distance_to(enemy.position)
	distance = clamp(distance, 0.8, 1.8)

	#toss
	if action.marker_type == "rotate":
		enemy.xz_vec += action.xz_toss.rotated(-self.rotation.y) / enemy.weight *5
		#the five is for counter in enemy weight, its only for not dividing by a flaot
		#number, then the system breaks
		
	else: 
		var xz_vec = Vector2(self.position.x, self.position.z)
		var rotat = xz_vec.direction_to(Vector2(enemy.position.x, enemy.position.z))
		rotat = rotat.angle_to(Vector2(0,1))
		
		enemy.xz_vec += action.xz_toss.rotated(-rotat) * distance / enemy.weight *5
		if enemy.y_tossable:
			enemy.y_vec += action.y_toss / distance / enemy.weight *5

	
	
	
	#later much more
	enemy.take_damage(damage_base)


#mozliwe ze pozniej to bedzie w animacjach playera
func anim_plays():
	PlayerInfo.is_moving = true
	PlayerInfo.combat_state ="during action"
	
	

func follow_up_set():
	if hitted and follow_allowed == true:
		if PlayerInfo.follows < PlayerInfo.follows_max:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "in menu"
			PlayerInfo.follows += 1
			if PlayerInfo.follows == PlayerInfo.follows_max:
				no_follows = true
				last_follow = true
				PlayerInfo.is_moving = true
				PlayerInfo.combat_state ="during action"
		
	
	else:
		hitted = false
		PlayerInfo.is_moving = true
		PlayerInfo.combat_state ="during action"

func _on_animation_player_animation_finished(anim_name):
	#when follows
	if follow_allowed:
		#this pi,follows can be taken and put in one place
		if PlayerInfo.combat_state == "moving":
			PlayerInfo.follows = 0

		elif hitted == false:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "in menu"
			PlayerInfo.follows = 0
		elif last_follow:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "in menu"
	
	#when follows not allowed
	else:
		PlayerInfo.is_moving = false
		PlayerInfo.combat_state = "in menu"
	self.queue_free()
