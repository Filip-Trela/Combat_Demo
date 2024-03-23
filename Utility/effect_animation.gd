extends Node3D

class_name EffectAnimation

@onready var anims = $AnimationPlayer

@export var damage_base = 25

var hitted = false
var no_follows = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anims.play("start")
	anim_plays()
	
func _process(delta):
	if PlayerInfo.is_moving:
		anims.play("start")
	else:
		anims.pause()


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.get_parent()
	hitted = true
	
	#later much more
	enemy.take_damage(damage_base)


#mozliwe ze pozniej to bedzie w animacjach playera
func anim_plays():
	PlayerInfo.is_moving = true
	PlayerInfo.combat_state ="during action"
	
func anims_end():
	if PlayerInfo.combat_state == "moving":
		PlayerInfo.follows = 0
	else:
		PlayerInfo.is_moving = false
		PlayerInfo.combat_state = "in menu"
	if no_follows:
		PlayerInfo.follows = 0
	self.queue_free()
	

func follow_up_set():
	if hitted:
		if PlayerInfo.follows < PlayerInfo.follows_max:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "in menu"
			anims.pause()
			PlayerInfo.follows += 1
			if PlayerInfo.follows == PlayerInfo.follows_max:
				no_follows = true
				PlayerInfo.is_moving = true
				PlayerInfo.combat_state ="during action"
		
			hitted = false
		


