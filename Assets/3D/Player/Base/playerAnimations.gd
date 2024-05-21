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
	player = get_parent().get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_hitbox_combat_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	
	var damage_base = action.damage[index_at]
	
	var enemy = area.get_parent().get_parent()
	hitted = true
	
	var distance = self.position.distance_to(enemy.position)
	distance = clamp(distance, 0.5, 1.2)
	
	var xz_vec = Vector2(self.position.x, self.position.z)
	var rotat = xz_vec.direction_to(Vector2(enemy.position.x, enemy.position.z))
	rotat = rotat.angle_to(Vector2(0,1))
		
	enemy.xz_vec += action.xz_toss.rotated(-rotat) * distance * 5 / enemy.weight 
	if enemy.y_tossable:
		enemy.y_vec += action.y_toss
	
	
	
	enemy.take_damage(damage_base, action)
	
func anim_starts():
	action = player.action
	follow_allowed = action.follow_allowed
	PlayerInfo.is_moving = true
	PlayerInfo.combat_state ="during action"


#to mozliwe ze tez wywalic
func follow_up_set():
	if hitted and follow_allowed == true:
		if PlayerInfo.follows < PlayerInfo.follows_max:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "moving"
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


#to moze zostac wywalone
func _on_animation_player_animation_finished(anim_name):
	#when follows
	print("bruh")
	if follow_allowed:
		#this pi,follows can be taken and put in one place
		if PlayerInfo.combat_state == "moving":
			PlayerInfo.follows = 0

		elif hitted == false:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "moving"
			PlayerInfo.follows = 0
		elif last_follow:
			PlayerInfo.is_moving = false
			PlayerInfo.combat_state = "moving"
			PlayerInfo.follows = 0
	
	#when follows not allowed
	else:
		PlayerInfo.is_moving = false
		PlayerInfo.combat_state = "moving"
		PlayerInfo.follows = 0
	
func next_index():
	index_at += 1


func stop_time():
	Settings.stopped_time = true

func start_time():
	Settings.stopped_time = false
