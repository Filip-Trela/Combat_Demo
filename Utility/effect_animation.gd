extends Node3D

class_name EffectAnimation

@onready var anims = $AnimationPlayer

@export var damage_base = 25

var hitted = false
var no_follows = false
var last_follow = false
var follow_allowed = false
var follow_nr:int

# Called when the node enters the scene tree for the first time.
func _ready():
	follow_nr = PlayerInfo.follows
	anim_plays()
	anims.play("start")
	
	
func _process(delta):
	pass
	#else:
	#	anims.pause()


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	hitted = true
	
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
		
			hitted = false
	
	else:
		hitted = false
		PlayerInfo.is_moving = true
		PlayerInfo.combat_state ="during action"

func _on_animation_player_animation_finished(anim_name):
	#when follows
	if follow_allowed:
		if hitted == false:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "in menu"
		elif PlayerInfo.combat_state == "moving":
			PlayerInfo.follows = 0
		elif last_follow:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "in menu"
		if no_follows:
			PlayerInfo.follows = 0
	
	#when follows not allowed
	else:
		PlayerInfo.is_moving = false
		PlayerInfo.combat_state = "in menu"
	self.queue_free()
