extends Node3D

var player
var action
var index_at = 0
var follow_allowed
var no_follows
var last_follow

var hitted:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_hitbox_combat_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var action = player.action
	
	var damage_base = action.damage[index_at]
	
	var enemy = area.get_parent().get_parent()
	hitted = true
	
	var distance = self.position.distance_to(enemy.position)
	distance = clamp(distance, 0.5, 1.2)
	
	#mozliwe ze pozniej wywalic
	enemy.xz_vec = Vector2(0,0)
	enemy.xz_vec += action.z_toss[index_at] * player.xz_dir
	if enemy.y_tossable:
		enemy.y_vec += action.y_toss[index_at]
	
	
	
	enemy.take_damage(damage_base, action)
	
func anim_starts():
	index_at = 0
	action = player.action
	follow_allowed = action.follow_allowed
	PlayerInfo.is_moving = true
	PlayerInfo.combat_state ="during action"



	
func next_index():
	index_at += 1


func stop_time():
	Settings.stopped_time = true

func start_time():
	Settings.stopped_time = false





func _on_hitbox_explore_body_entered(body):
	player.hitbox_explore_body_entered(body)
